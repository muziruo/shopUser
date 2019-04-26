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
    
    [self getReceiptLocal];
    // Do any additional setup after loading the view.
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
        }
        
        NSString *totalAddress = [[self.selectedLocal valueForKey:@"area"] stringByAppendingString:[self.selectedLocal valueForKey:@"address"]];
        cell.receiptLocal.text = totalAddress;
        
        return cell;
    }else if (indexPath.section == 1) {
        commodityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commodityCell"];
        
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
