//
//  orderTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/23.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <PPNumberButton/PPNumberButton.h>

NS_ASSUME_NONNULL_BEGIN


//此cell为地址cell
@interface orderTableViewCell : UITableViewCell

@property UILabel *receiptName;
@property UILabel *receiptNumber;
@property UILabel *receiptLocal;
@property UILabel *isDefalut;

@end


//此cell为商品信息cell
@interface commodityInfoCell : UITableViewCell

@property UIImageView *commodityImage;
@property UILabel *commodityName;
@property UILabel *commodityPrice;
@property UILabel *commodityModel;
@property UILabel *shopName;
@property UIView *numberArea;
@property UILabel *number;
@property PPNumberButton *numberButton;

@end

NS_ASSUME_NONNULL_END
