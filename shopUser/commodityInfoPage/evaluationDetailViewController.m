//
//  evaluationDetailViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/26.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "evaluationDetailViewController.h"

@interface evaluationDetailViewController ()

@end

@implementation evaluationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = @0;
    
    self.evaluationTableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.evaluationInfo = [[NSArray alloc] init];
    //self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeCommodity)];
    self.evaluationTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reLoadInfo)];
    self.evaluationTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(addInfo)];
    
    [self.evaluationTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}


-(void)reLoadInfo {
    [self getEvaluationInfo:1];
}


-(void)addInfo {
    [self getEvaluationInfo:2];
}


//获取评论信息
-(void)getEvaluationInfo:(int)withRefreshType {

    NSDictionary *params = @{@"commodityId":self.commodityId,@"type":@2,@"page":self.page};
    [AVCloud callFunctionInBackground:@"getCommodityEvaluation" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([object valueForKey:@"success"]) {
                if (withRefreshType == 1) {
                    self.evaluationInfo = [object valueForKey:@"resultInfo"];
                }else {
                    self.evaluationInfo = [self.evaluationInfo arrayByAddingObjectsFromArray:[object valueForKey:@"resultInfo"]];
                }
                //self.evaluationInfo = newInfoList;
                //self.evaluationInfo = [object valueForKey:@"resultInfo"];
                NSLog(@"数组元素个数为:%lu",(unsigned long)[self.evaluationInfo count]);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.evaluationTableView.mj_header endRefreshing];
                    [self.evaluationTableView reloadData];
                }];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.evaluationInfo count];
}


//请在此配置数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentTableViewCell"];
    
    if (!cell) {
        cell = [[commentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentTableViewCell"];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:[[self.evaluationInfo[indexPath.row] valueForKey:@"userId"] valueForKey:@"avatar"]];
    [cell.userAvator sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
    cell.userNickName.text = [[self.evaluationInfo[indexPath.row] valueForKey:@"userId"] valueForKey:@"nickName"];
    cell.commentInfo.text = [self.evaluationInfo[indexPath.row] valueForKey:@"info"];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
