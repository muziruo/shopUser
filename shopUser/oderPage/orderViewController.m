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
    self.orderTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.sureButton.backgroundColor = UIColor.stressColor;
    self.sureButton.titleLabel.font = UIFont.normalFontLight;
    [self.sureButton addTarget:self action:@selector(sureOrder) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}


//获取收货地址



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        orderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"];
        
        if (!cell) {
            cell = [[orderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localCell"];
        }
        
        cell.receiptName.text = @"收货人";
        cell.receiptNumber.text = @"12345678909";
        cell.isDefalut.text = @"默认";
        cell.receiptLocal.text = @"收货地址收货地址收货地址收货地址收货地址收货地址收货地址收货地址收货地址收货地址";
        
        return cell;
    }else if (indexPath.section == 1) {
        commodityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commodityCell"];
        
        if (!cell) {
            cell = [[commodityInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commodityCell"];
            
            cell.commodityName.text = @"商品名称";
            cell.commodityImage.image = [UIImage imageNamed:@"imageReplace-s"];
            cell.commodityPrice.text = @"商品价格";
            cell.commodityModel.text = @"商品型号";
            cell.shopName.text = @"店铺名称";
            //cell.number.text = @"商品数量";
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)sureOrder {
    [self.navigationController popViewControllerAnimated:true];
}

@end
