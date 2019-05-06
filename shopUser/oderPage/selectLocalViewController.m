//
//  selectLocalViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/27.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "selectLocalViewController.h"

@interface selectLocalViewController ()

@end

@implementation selectLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self getAllLocal];
    // Do any additional setup after loading the view.
}

-(void)getAllLocal {
    NSDictionary *params = @{@"userId":@"5cbc8182c8959c00751357ca"};
    [AVCloud callFunctionInBackground:@"getReceiptLocal" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.localList = object;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.localListTableView reloadData];
            }];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.localList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        pointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pointCell"];
        
        if (!cell) {
            cell = [[pointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pointCell"];
        }
        
        cell.pointInfo.text = @"选择地址";
        cell.pointInfo.font = UIFont.titleFont;
        cell.pointInfo.textColor = UIColor.blackColor;
        
        return cell;
    }
    
    orderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"];
    
    if (!cell) {
        cell = [[orderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localCell"];
    }
    
    cell.receiptName.text = [self.localList[indexPath.row - 1] valueForKey:@"name"];
    cell.receiptNumber.text = [self.localList[indexPath.row - 1] valueForKey:@"phoneNumber"];
    NSString *totalLocal = [[self.localList[indexPath.row - 1] valueForKey:@"area"] stringByAppendingString:[self.localList[indexPath.row - 1] valueForKey:@"address"]];
    cell.receiptLocal.text = totalLocal;
    
    if ([[self.localList[indexPath.row - 1] valueForKey:@"isDefault"]  isEqual: @1]) {
        cell.isDefalut.text = @"默认";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else {
        if ([self.delegate respondsToSelector:@selector(changeLocal:)]) {
            [self.delegate changeLocal:(indexPath.row - 1)];
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

@end
