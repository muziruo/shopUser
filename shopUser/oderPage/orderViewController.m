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
@property BOOL addLocal;

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
    
    if (self.fromShoppingCar) {
        self.payArray = [[NSMutableArray alloc] init];
    }
    
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
    float totalPrice = 0;
    for (int i = 0 ; i < [self.commodityList count]; i++) {
        PPNumberButton *number = (PPNumberButton*)[self.view viewWithTag:(101 + i)];
        NSNumber *price = [[NSNumber alloc] init];
        if (self.fromShoppingCar) {
            price = [[self.commodityList[i] valueForKey:@"commodity"] valueForKey:@"price"];
        }else {
            price = [self.commodityList[i] valueForKey:@"price"];
        }
        NSNumber *commodityNumber = [NSNumber numberWithFloat:number.currentNumber];
        if (self.fromShoppingCar) {
            NSNumber *simplePrice = [NSNumber numberWithFloat:(commodityNumber.integerValue * price.floatValue)];
            [self.payArray addObject:simplePrice];
        }
        totalPrice = commodityNumber.intValue * price.floatValue + totalPrice;
    }
    self.actualPay = [NSNumber numberWithInteger:totalPrice];
    NSString *priceString = [NSString stringWithFormat:@"%f",totalPrice];
    self.totalPrice.text = priceString;
}


//获取所有收货地址
-(void)getReceiptLocal {
    NSDictionary *params = @{@"userId":[AVUser currentUser].objectId};
    [AVCloud callFunctionInBackground:@"getReceiptLocal" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.localList = object;
            for (int i = 0; i < [object count]; i++) {
                if ([[object[i] valueForKey:@"isDefault"]  isEqual:@1]) {
                    self.selectedLocal = object[i];
                }
            }
            if ([object count] == 0) {
                self.addLocal = true;
            }else{
                self.addLocal = false;
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
            
            if (self.fromShoppingCar) {
                
                cell.commodityName.text = [[self.commodityList[indexPath.row] valueForKey:@"commodity"] valueForKey:@"name"];
                
                NSURL *imageUrl = [NSURL URLWithString:[[self.commodityList[indexPath.row] valueForKey:@"commodity"] valueForKey:@"mainImage"]];
                [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
                
                //NSString *priceText = [NSNumberFormatter localizedStringFromNumber:[[self.commodityList[indexPath.row] valueForKey:@"commodity"] valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
                NSString *priceText = [NSString stringWithFormat:@"%@",[[self.commodityList[indexPath.row] valueForKey:@"commodity"] valueForKey:@"price"]];
                NSString *totalPrice = [@"¥" stringByAppendingString:priceText];
                cell.commodityPrice.text = totalPrice;
                
                cell.commodityModel.text = [[self.commodityList[indexPath.row] valueForKey:@"commodityStock"] valueForKey:@"commodityModel"];
                
                cell.shopName.text = [[[self.commodityList[indexPath.row] valueForKey:@"commodity"] valueForKey:@"shop"] valueForKey:@"name"];
                
                NSNumber *number = [[NSNumber alloc] init];
                number = self.buyNumber[indexPath.row];
                
                cell.numberButton.currentNumber = number.floatValue;
                [cell.numberButton setTag:(101 + indexPath.row)];
                cell.numberButton.delegate = self;
                
            }else {
            
                cell.commodityName.text = [self.commodityList[indexPath.row] valueForKey:@"name"];
                
                NSURL *imageUrl = [NSURL URLWithString:[self.commodityList[indexPath.row] valueForKey:@"mainImage"]];
                [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imagePlace-s"]];
                
                //NSString *priceText = [NSNumberFormatter localizedStringFromNumber:[self.commodityList[indexPath.row] valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
                NSString *priceText = [NSString stringWithFormat:@"%@",[self.commodityList[indexPath.row] valueForKey:@"price"]];
                NSString *totalPrice = [@"¥" stringByAppendingString:priceText];
                cell.commodityPrice.text = totalPrice;
                
                cell.commodityModel.text = [self.selectedStock valueForKey:@"commodityModel"];
                cell.shopName.text = [[self.commodityList[indexPath.row] valueForKey:@"shop"] valueForKey:@"name"];
                //cell.number.text = @"商品数量";
                
                //cell.numberButton.tag = 101 + indexPath.row;
                [cell.numberButton setTag:(101 + indexPath.row)];
                cell.numberButton.delegate = self;
            }
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
        if (self.addLocal) {
            localEditViewController *localEditView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"editLocalView"];
            localEditView.delegate = self;
            localEditView.editOrCreate = 0;
            localEditView.isFrist = true;
            [self.navigationController pushViewController:localEditView animated:true];
        }else{
            selectLocalViewController *localListView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"localListView"];
            localListView.localList = self.localList;
            localListView.delegate = self;
            [self presentViewController:localListView animated:true completion:nil];
        }
    }
}


//代理回调函数
- (void)changeLocal:(long)selectedRow {
    self.selectedLocal = self.localList[selectedRow];
    NSLog(@"开始更新地址,更新为%@",self.selectedLocal);
    [self.orderTableView reloadData];
}


//代理回调刷新
- (void)addedLocal {
    [self getReceiptLocal];
}


//确认订单并且进行提交，注意此处提交使用的是userInfo表中的Id
- (void)sureOrder {
//
    dispatch_queue_t doQueue = dispatch_queue_create("muziruo.com", DISPATCH_QUEUE_SERIAL);
//    首先整理数据，可能有多个商品，所以可能需要创建多个订单
    NSString *receiptLocal = [[self.selectedLocal valueForKey:@"area"] stringByAppendingString:[self.selectedLocal valueForKey:@"address"]];
    
    self.successNumber = [self.commodityList count];
    
    for (int i = 0; i < [self.commodityList count]; i ++) {
//        所订购商品的数量
        PPNumberButton *currentNumber = [self.view viewWithTag:(101 + i)];
        NSNumber *commodityNumber = [NSNumber numberWithFloat:currentNumber.currentNumber];
        
//        商品所属店铺
        NSString *shopId = [[NSString alloc] init];
        if (self.fromShoppingCar) {
            shopId = [[[self.commodityList[i] valueForKey:@"commodity"] valueForKey:@"shop"] valueForKey:@"objectId"];
        }else {
            shopId = [[self.commodityList[i] valueForKey:@"shop"] valueForKey:@"objectId"];
        }
        
//        型号信息
        NSString *model = [[NSString alloc] init];
        if (self.fromShoppingCar) {
            model = [[self.commodityList[i] valueForKey:@"commodityStock"] valueForKey:@"commodityModel"];
        }else {
            model = [self.selectedStock valueForKey:@"commodityModel"];
        }
        
//        商品Id
        NSString *commodityId = [[NSString alloc] init];
        if (self.fromShoppingCar) {
            commodityId = [[self.commodityList[i] valueForKey:@"commodity"] valueForKey:@"objectId"];
        }else {
            commodityId = [self.commodityList[i] valueForKey:@"objectId"];
        }
        
//        价格
        NSNumber *paramsPrice = [[NSNumber alloc] init];
        if (self.fromShoppingCar) {
            paramsPrice = self.payArray[i];
        }else {
            paramsPrice = self.actualPay;
        }
        
//        组装参数
        NSDictionary *params = @{
                                 @"userId":[AVUser currentUser].objectId,
                                 @"orderStatus":@1,
                                 @"number":commodityNumber,
                                 @"shopId":shopId,
                                 @"actualPay":paramsPrice,
                                 @"commodityId":commodityId,
                                 @"receiptName":[self.selectedLocal valueForKey:@"name"],
                                 @"commodityModel":model,
                                 @"receiptLocal":receiptLocal,
                                 @"receiptPhoneNumber":[self.selectedLocal valueForKey:@"phoneNumber"]
                                 };
//        数据组装完毕
        
        NSLog(@"数据为:%@",params);
        
        //continue;
        
        [AVCloud callFunctionInBackground:@"createOrder" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([object valueForKey:@"success"]) {
                    
                    if (self.fromShoppingCar) {
                        NSDictionary *deleteParams = @{@"shoppingCarId":[self.commodityList[i] valueForKey:@"objectId"]};
                        [AVCloud callFunctionInBackground:@"deleteCart" withParameters:deleteParams block:^(id  _Nullable object, NSError * _Nullable error) {
                            
                        }];
                    }
                    
//                    为数组添加元素，用于确定所有订单是否下单完毕
                    dispatch_barrier_sync(doQueue, ^{
                        
                        self.successNumber--;
                        
                    });
                    
                    if (self.successNumber == 0) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [SVProgressHUD showSuccessWithStatus:@"下单成功"];
                            [SVProgressHUD dismissWithDelay:0.8];
                            [self.navigationController popViewControllerAnimated:true];
                        }];
                    }
                    
                }
            }
        }];
    }
}

@end
