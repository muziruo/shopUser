//
//  orderViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/23.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import "orderTableViewCell.h"
#import <PPNumberButton/PPNumberButton.h>

NS_ASSUME_NONNULL_BEGIN

@interface orderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *orderTableView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

//订单页面数据有：商品信息列表、店铺信息列表、收货地址列表
@property NSArray *localList;
@property NSArray *commodityList;
@property NSArray *shopList;

//选中的地址以及地址id
@property NSString *selectedLocalId;
@property NSDictionary *selectedLocal;

@end

NS_ASSUME_NONNULL_END
