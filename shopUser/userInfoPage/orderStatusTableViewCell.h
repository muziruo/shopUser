//
//  orderStatusTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/24.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <Masonry/Masonry.h>
#import "evaluateViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface orderStatusTableViewCell : UITableViewCell

@property UIImageView *commodityImage;
@property UILabel *commodityName;
@property UILabel *commodityModel;
@property UILabel *commodityShop;
@property UILabel *commodityStatus;

@end


//待收货订单
@interface waitReceiptCell : UITableViewCell

@property UIImageView *commodityImage;
@property UILabel *commodityName;
@property UILabel *commodityModel;
@property UILabel *commodityShop;
@property UILabel *commodityStatus;
@property UIButton *sureReceipt;

@end



//待评价订单
@interface waitEvaluateCell : UITableViewCell

@property UIImageView *commodityImage;
@property UILabel *commodityName;
@property UILabel *commodityModel;
@property UILabel *commodityShop;
@property UILabel *commodityStatus;
@property UIButton *evaluate;

@end



//历史订单
@interface historyCell : UITableViewCell

@property UIImageView *commodityImage;
@property UILabel *commodityName;
@property UILabel *commodityModel;
@property UILabel *commodityShop;
@property UILabel *commodityStatus;

@end


NS_ASSUME_NONNULL_END
