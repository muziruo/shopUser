//
//  shoppingCarViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "shoppingCarViewController.h"

@interface shoppingCarViewController ()

@property NSMutableArray *shoppingCarInfo;

@end

@implementation shoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shopCarTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    _buyButton.backgroundColor = UIColor.buttonColor;
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    
    self.shopCarTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getShoppingCarInfo)];
    
    self.selectAll.backgroundColor = UIColor.voidColor;
    [self.selectAll addTarget:self action:@selector(selectAllCommodity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buyButton addTarget:self action:@selector(sureBuy) forControlEvents:UIControlEventTouchUpInside];
    
    [self getShoppingCarInfo];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated {
    [self getShoppingCarInfo];
}


//确认购买
-(void)sureBuy {
    NSMutableArray *newList = [[NSMutableArray alloc] init];
    NSMutableArray *listNumber = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.shoppingCarInfo count]; i++) {
        SUSelectButton *SUbutton = [self.view viewWithTag:(201 + i)];
        PPNumberButton *selectButton = [self.view viewWithTag:(101 + i)];
        if (CGColorEqualToColor(SUbutton.backgroundColor.CGColor, UIColor.themeMainColor.CGColor)) {
            [newList addObject:self.shoppingCarInfo[i]];
            [listNumber addObject:[NSNumber numberWithFloat:selectButton.currentNumber]];
        }
    }
    NSLog(@"传递元素数量%lu",[newList count]);
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    orderViewController *orderView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"orderView"];
    orderView.commodityList = newList;
    orderView.fromShoppingCar = true;
    orderView.buyNumber = listNumber;
    [self.navigationController pushViewController:orderView animated:true];
}


//计算总价
-(void)countTotalPrice {
    float total = 0;
    int SUSelectedNumber = 0;
    for (int i = 0; i < [self.shoppingCarInfo count]; i++) {
        SUSelectButton *SUButton = [self.view viewWithTag:(201 + i)];
        PPNumberButton *numberButton = [self.view viewWithTag:(101 + i)];
        
//        需要修改此时购物车数据，以让跳转到订单页面也是正确的数据
        //[self.shoppingCarInfo[i] setValue:[NSNumber numberWithFloat:numberButton.currentNumber] forKey:@"number"];
        
        if (CGColorEqualToColor(SUButton.backgroundColor.CGColor, UIColor.themeMainColor.CGColor)) {
            SUSelectedNumber++;
            NSNumber *number = [NSNumber numberWithFloat:numberButton.currentNumber];
            NSNumber *price = [[self.shoppingCarInfo[i] valueForKey:@"commodity"] valueForKey:@"price"];
            total = total + number.intValue * price.floatValue;
        }
    }
    if (SUSelectedNumber != [self.shoppingCarInfo count]) {
        self.selectAll.backgroundColor = UIColor.voidColor;
    }else if (SUSelectedNumber == [self.shoppingCarInfo count]){
        self.selectAll.backgroundColor = UIColor.themeMainColor;
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
                [self.shopCarTableView.mj_header endRefreshing];
                [self.shopCarTableView reloadData];
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
    
    [myCell.selectButton setTag:(201 + indexPath.row)];
    myCell.selectButton.selectDelegate = self;
    
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

//SUSelectButton代理方法
- (void)SUSelectButtonChangeStatus:(SUSelectButton *)selectedButton {
    NSLog(@"点击代理");
    //selectedButton.backgroundColor = UIColor.themeMainColor;
    if (CGColorEqualToColor(selectedButton.backgroundColor.CGColor, UIColor.voidColor.CGColor)) {
        selectedButton.backgroundColor = UIColor.themeMainColor;
    }else if (CGColorEqualToColor(selectedButton.backgroundColor.CGColor, UIColor.themeMainColor.CGColor)) {
        selectedButton.backgroundColor = UIColor.voidColor;
    }
    [self countTotalPrice];
}


-(void)selectAllCommodity {
    if (CGColorEqualToColor(self.selectAll.backgroundColor.CGColor, UIColor.voidColor.CGColor)) {
        self.selectAll.backgroundColor = UIColor.themeMainColor;
        for (int i = 0; i < [self.shoppingCarInfo count]; i++) {
            SUSelectButton *SUButton = [self.view viewWithTag:(201 + i)];
            SUButton.backgroundColor = UIColor.themeMainColor;
        }
    }else if (CGColorEqualToColor(self.selectAll.backgroundColor.CGColor, UIColor.themeMainColor.CGColor)){
        self.selectAll.backgroundColor = UIColor.voidColor;
        for (int i = 0; i < [self.shoppingCarInfo count]; i++) {
            SUSelectButton *SUButton = [self.view viewWithTag:(201 + i)];
            SUButton.backgroundColor = UIColor.voidColor;
        }
    }
    [self countTotalPrice];
}


@end
