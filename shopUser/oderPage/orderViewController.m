//
//  orderViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/23.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderViewController.h"

@interface orderViewController ()

@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = UIColor.voidColor;
    
    self.sureButton.backgroundColor = UIColor.stressColor;
    self.sureButton.titleLabel.font = UIFont.normalFontLight;
    [self.sureButton.titleLabel setTextColor:UIColor.whiteColor];
    // Do any additional setup after loading the view.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    orderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"];
    
    if (!cell) {
        cell = [[orderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localCell"];
    }
    
    cell.receiptName.text = @"收货人";
    cell.receiptNumber.text = @"12345678909";
    cell.isDefalut.text = @"默认";
    cell.receiptLocal.text = @"收货地址收货地址收货地址收货地址收货地址收货地址收货地址收货地址收货地址收货地址";
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

@end
