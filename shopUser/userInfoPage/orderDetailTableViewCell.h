//
//  orderDetailTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/25.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface orderDetailTableViewCell : UITableViewCell

@property UILabel *orderIdTitle;
@property UILabel *orderId;

@property UILabel *orderSubmitTimeTitle;
@property UILabel *orderSubmitTime;

@property UILabel *orderReceiptTimeTitle;
@property UILabel *orderReceiptTime;

@end

NS_ASSUME_NONNULL_END
