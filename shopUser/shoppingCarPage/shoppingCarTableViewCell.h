//
//  shoppingCarTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+themeUIFont.h"

NS_ASSUME_NONNULL_BEGIN

@interface shoppingCarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commodityImage;
@property (weak, nonatomic) IBOutlet UILabel *commodityName;
@property (weak, nonatomic) IBOutlet UILabel *descriptionInfo;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextField *commodityNumber;


@end

NS_ASSUME_NONNULL_END
