//
//  infoViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/19.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "baseInfoTableViewCell.h"
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <BRPickerView/BRPickerView.h>
#import <AVOSCloud/AVOSCloud.h>
#import "orderViewController.h"
#import "evaluationDetailViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ARViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface infoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property NSDictionary *info;
@property NSDictionary *detailInfo;
@property NSArray *stock;
@property NSArray *imageArray;
@property NSDictionary *selectedModel;

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property SDCycleScrollView *commodityImage;
@property (weak, nonatomic) IBOutlet UIView *imageArea;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *addCart;
@property (weak, nonatomic) IBOutlet UIButton *collect;
@property (weak, nonatomic) IBOutlet UIButton *inToShop;


@end

NS_ASSUME_NONNULL_END
