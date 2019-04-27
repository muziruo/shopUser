//
//  orderViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/23.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderViewController.h"

@interface orderViewController ()

@property UIStoryboard *mainStoryBroad;

@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //self.view.backgroundColor = UIColor.voidColor;
    self.orderTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.sureButton.backgroundColor = UIColor.stressColor;
    self.sureButton.titleLabel.font = UIFont.normalFontLight;
    [self.sureButton addTarget:self action:@selector(sureOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self getReceiptLocal];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated {
    [self countTotalPrice];
}


- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus {
    NSLog(@"执行代理");
    [self countTotalPrice];
}


-(void)countTotalPrice {
    int totalPrice = 0;
    for (int i = 0 ; i < [self.commodityList count]; i++) {
        PPNumberButton *number = (PPNumberButton*)[self.view viewWithTag:(101 + i)];
        if (number == nil) {
            NSLog(@"未获取到相应的数量控制器");
        }
        NSNumber *price = [self.commodityList[i] valueForKey:@"price"];
        NSLog(@"当前单品价:%@",price);
        NSNumber *commodityNumber = [NSNumber numberWithFloat:number.currentNumber];
        NSLog(@"当前个数:%@",commodityNumber);
        totalPrice = commodityNumber.intValue * price.intValue + totalPrice;
    }
    self.actualPay = [NSNumber numberWithInteger:totalPrice];
    NSString *priceString = [NSString stringWithFormat:@"%d",totalPrice];
    self.totalPrice.text = priceString;
}


//获取所有收货地址
-(void)getReceiptLocal {
    NSDictionary *params = @{@"userId":@"5cbc8182c8959c00751357ca"};
    [AVCloud callFunctionInBackground:@"getReceiptLocal" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.localList = object;
            for (int i = 0; i < [object count]; i++) {
                if ([[object[i] valueForKey:@"isDefault"]  isEqual:@1]) {
                    self.selectedLocal = object[i];
                }
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.orderTableView reloadData];
            }];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [self.commodityList count];
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (self.selectedLocal == nil) {
            pointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pointCell"];
            
            if (!cell) {
                cell = [[pointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pointCell"];
            }
            
            cell.pointInfo.text = @"尚未找到地址，点击进行添加";
            
            return cell;
        }
        
        orderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"];
        
        if (!cell) {
            cell = [[orderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localCell"];
        }
        
        cell.receiptName.text = [self.selectedLocal valueForKey:@"name"];
        cell.receiptNumber.text = [self.selectedLocal valueForKey:@"phoneNumber"];
        
        if ([[self.selectedLocal valueForKey:@"isDefault"] isEqual:@1]) {
            cell.isDefalut.text = @"默认";
        }else {
            cell.isDefalut.text = @"";
        }
        
        NSString *totalAddress = [[self.selectedLocal valueForKey:@"area"] stringByAppendingString:[self.selectedLocal valueForKey:@"address"]];
        cell.receiptLocal.text = totalAddress;
        
        return cell;
    }else if (indexPath.section == 1) {
        commodityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commodityCell"];
        
//        设置商品信息
        if (!cell) {
            cell = [[commodityInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commodityCell"];
            
            cell.commodityName.text = [self.commodityList[indexPath.row] valueForKey:@"name"];
            
            NSURL *imageUrl = [NSURL URLWithString:[self.commodityList[indexPath.row] valueForKey:@"mainImage"]];
            [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imagePlace-s"]];
            
            NSString *priceText = [NSNumberFormatter localizedStringFromNumber:[self.commodityList[indexPath.row] valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
            NSString *totalPrice = [@"¥" stringByAppendingString:priceText];
            cell.commodityPrice.text = totalPrice;
            
            cell.commodityModel.text = [self.selectedStock valueForKey:@"commodityModel"];
            cell.shopName.text = [[self.commodityList[indexPath.row] valueForKey:@"shop"] valueForKey:@"name"];
            //cell.number.text = @"商品数量";
            
            //cell.numberButton.tag = 101 + indexPath.row;
            [cell.numberButton setTag:(101 + indexPath.row)];
            cell.numberButton.delegate = self;
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
    
    if (indexPath.section == 0) {
        selectLocalViewController *localListView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"localListView"];
        localListView.localList = self.localList;
        localListView.delegate = self;
        [self presentViewController:localListView animated:true completion:nil];
    }
}


//代理回调函数
- (void)changeLocal:(long)selectedRow {
    self.selectedLocal = self.localList[selectedRow];
    NSLog(@"开始更新地址,更新为%@",self.selectedLocal);
    [self.orderTableView reloadData];
}


//确认订单并且进行提交，注意此处提交使用的是userInfo表中的Id
- (void)sureOrder {
//    首先整理数据，可能有多个商品，所以可能需要创建多个订单
    NSString *receiptLocal = [[self.selectedLocal valueForKey:@"area"] stringByAppendingString:[self.selectedLocal valueForKey:@"address"]];
    
    for (int i = 0; i < [self.commodityList count]; i ++) {
//        所订购商品的数量
        PPNumberButton *currentNumber = [self.view viewWithTag:(101 + i)];
        NSNumber *commodityNumber = [NSNumber numberWithFloat:currentNumber.currentNumber];
//        商品所属店铺
        NSString *shopId = [[self.commodityList[i] valueForKey:@"shop"] valueForKey:@"objectId"];
//        型号信息
        NSString *model = [[NSString alloc] init];
        if (self.fromShoppingCar) {
//            配置购物车的x各类型号
            
        }else {
//            配置单个商品的型号
            model = [self.selectedStock valueForKey:@"commodityModel"];
        }
//        组装参数
        NSDictionary *params = @{
                                 @"userId":@"5cbc81e6a3180b7832cd059a",
                                 @"orderStatus":@1,
                                 @"number":commodityNumber,
                                 @"shopId":shopId,
                                 @"actualPay":self.actualPay,
                                 @"commodityId":[self.commodityList[i] valueForKey:@"objectId"],
                                 @"receiptName":[self.selectedLocal valueForKey:@"name"],
                                 @"commodityModel":model,
                                 @"receiptLocal":receiptLocal,
                                 @"receiptPhoneNumber":[self.selectedLocal valueForKey:@"phoneNumber"]
                                 };
//        数据组装完毕
        
        NSLog(@"数据为:%@",params);
        
        [AVCloud callFunctionInBackground:@"createOrder" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([object valueForKey:@"success"]) {
                    [SVProgressHUD showSuccessWithStatus:@"下单成功"];
                    [SVProgressHUD dismissWithDelay:0.5];
                    [self.navigationController popViewControllerAnimated:true];
                }
            }
        }];
    }

}

@end
