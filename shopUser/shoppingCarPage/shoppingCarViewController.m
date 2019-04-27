//
//  shoppingCarViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "shoppingCarViewController.h"

@interface shoppingCarViewController ()

@property NSArray *shoppingCarInfo;

@end

@implementation shoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shopCarTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    _buyButton.backgroundColor = UIColor.buttonColor;
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    
    self.shopCarTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getShoppingCarInfo)];
    
    [self getShoppingCarInfo];
    // Do any additional setup after loading the view.
}


//计算总价
-(void)countTotalPrice {
    float total = 0;
    for (int i = 0; i < [self.shoppingCarInfo count]; i++) {
        PPNumberButton *numberButton = [self.view viewWithTag:(101 + i)];
        NSNumber *number = [NSNumber numberWithFloat:numberButton.currentNumber];
        NSNumber *price = [[self.shoppingCarInfo[i] valueForKey:@"commodity"] valueForKey:@"price"];
        total = total + number.intValue * price.floatValue;
    }
    self.totalPrice = [NSNumber numberWithDouble:total];
    NSString *priceString = [NSString stringWithFormat:@"%f",total];
    self.totalPriceText.text = priceString;
}


//获取购物车信息
-(void)getShoppingCarInfo {
    [self.shopCarTableView.mj_header beginRefreshing];
    
    NSDictionary *params = @{@"userId":@"5cbc8182c8959c00751357ca"};
    [AVCloud callFunctionInBackground:@"getShoppingCar" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.shoppingCarInfo = object;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.shopCarTableView reloadData];
                [self.shopCarTableView.mj_header endRefreshing];
                [self countTotalPrice];
            }];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shoppingCarInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    shoppingCarTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCarCell" forIndexPath:indexPath];
    
    
//    配置cell中的数据
    NSURL *imageUrl = [NSURL URLWithString:[[self.shoppingCarInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"mainImage"]];
    [myCell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
    myCell.commodityName.text = [[self.shoppingCarInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"name"];
    myCell.descriptionInfo.text = [[self.shoppingCarInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"description"];
    NSNumber *number = [self.shoppingCarInfo[indexPath.row] valueForKey:@"number"];
    myCell.numberButton.currentNumber = number.floatValue;
    [myCell.numberButton setTag:(101 + indexPath.row)];
    myCell.numberButton.delegate = self;
    
    NSString *priceTitle = @"¥";
    NSString *price = [NSNumberFormatter localizedStringFromNumber:[[self.shoppingCarInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
    priceTitle = [priceTitle stringByAppendingString:price];
    myCell.price.text = price;
    
    //[myCell.selectButton addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    
    return myCell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    infoViewController *commodityInfo = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityInfoView"];
    commodityInfo.info = [self.shoppingCarInfo[indexPath.row] valueForKey:@"commodity"];
    [self.navigationController pushViewController:commodityInfo animated:YES];
}


//ppnumberbutton代理方法
- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus {
    [self countTotalPrice];
}


-(void)changeColor {
    
}

@end
