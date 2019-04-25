//
//  orderDetailViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/25.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderDetailViewController.h"

@interface orderDetailViewController ()

@end

@implementation orderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        receiptLocalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"receiptLocalCell"];
        
        if (!cell) {
            cell = [[receiptLocalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"receiptLocalCell"];
        }
        
        cell.receiptName.text = @"收货人";
        cell.receiptLocal.text = @"收货地址";
        cell.receiptNumber.text = @"12345678909";
        
        return cell;
    }else if (indexPath.section == 1){
        orderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderStatusCell"];
        
        if (!cell) {
            cell = [[orderStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderStatusCell"];
        }
        
        cell.commodityName.text = @"商品名称";
        cell.commodityShop.text = @"店铺名称";
        cell.commodityImage.image = [UIImage imageNamed:@"imageReplace-s"];
        cell.commodityModel.text = @"商品型号";
        cell.commodityStatus.text = @"订单完成";
        
        return cell;
    }else if (indexPath.section == 2){
        orderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailCell"];
        
        if (!cell) {
            cell = [[orderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderDetailCell"];
        }
        
        cell.orderIdTitle.text = @"订单编号";
        cell.orderSubmitTimeTitle.text = @"提交时间";
        cell.orderReceiptTimeTitle.text = @"收货时间";
        
        cell.orderId.text = @"23nafd2jdna";
        cell.orderReceiptTime.text = @"2019-04-01";
        cell.orderSubmitTime.text = @"2019-04-03";
        
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

@end
