//
//  receiptLocalViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "receiptLocalViewController.h"

@interface receiptLocalViewController ()

@property NSArray *receiptLocalInfo;
@property UIStoryboard *mainStoryBroad;

@end

@implementation receiptLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.addLoacl.backgroundColor = UIColor.buttonColor;
    // Do any additional setup after loading the view.
}

//请在此配置网络数据请求
- (void)getReceiptLocalInfo {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    receiptLocalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"];
    
    if (!cell) {
        cell = [[receiptLocalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localCell"];
    }
    
    if (indexPath.row == 0) {
        cell.isDefault.text = @"默认";
    }
    
    cell.receiptLocal.text = @"收货地址 收货地址 收货地址 收货地址 收货地址 收货地址 收货地址 收货地址 收货地址 收货地址";
    cell.receiptName.text = @"姓名";
    cell.receiptNumber.text = @"12412742938";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    localEditViewController *editView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"editLocalView"];
    [self.navigationController pushViewController:editView animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
