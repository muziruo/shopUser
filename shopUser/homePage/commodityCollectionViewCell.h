//
//  commodityCollectionViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+themeUIFont.h"

NS_ASSUME_NONNULL_BEGIN

@interface commodityCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView *commodityImage;
@property (nonatomic) UILabel *commodityName;
@property (nonatomic) UILabel *price;

@end

NS_ASSUME_NONNULL_END
