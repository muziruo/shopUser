//
//  evaluateViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/26.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "evaluateViewController.h"

@interface evaluateViewController ()

@end

@implementation evaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.voidColor;
    
    self.score = @5;
    
    self.stars = [[GRStarsView alloc] initWithStarSize:CGSizeMake(40, 40) margin:10 numberOfStars:5];
    self.stars.allowDecimal = NO;
    [self.scoreArea addSubview:self.stars];
    self.scoreArea.backgroundColor = UIColor.clearColor;
    
    __weak typeof(self)weakSelf = self;
    self.stars.touchedActionBlock = ^(CGFloat score) {
        weakSelf.score = [NSNumber numberWithFloat:score];
        NSLog(@"当前选择的分数:%@",weakSelf.score);
    };
    
    [self.submitButton addTarget:self action:@selector(submitEvaluate) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


-(void)submitEvaluate {
    [SVProgressHUD showWithStatus:@"正在提交"];
    NSString *info = self.inputInfo.text;
    if (info != nil) {
        NSDictionary *params = @{@"commodityId":@"5caeae5ca673f50068cfdb0f",@"info":info,@"score":self.score,@"userId":@"5cbc81e6a3180b7832cd059a"};
        [AVCloud callFunctionInBackground:@"addEvaluate" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"添加成功");
                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                [SVProgressHUD dismissWithDelay:0.5];
                [self.navigationController popViewControllerAnimated:true];
            }
        }];
        
    }
    
}

@end
