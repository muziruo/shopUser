//
//  commodityCollectionViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "commodityCollectionViewCell.h"

@implementation commodityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.commodityName = [[UILabel alloc] init];
        self.commodityImage = [[UIImageView alloc] init];
        self.price = [[UILabel alloc] init];
        self.commodityName.backgroundColor = UIColor.whiteColor;
        self.price.backgroundColor = UIColor.whiteColor;
        
        self.commodityName.font = UIFont.normalFont;
        self.price.font = UIFont.numberFont;
        self.price.textColor = UIColor.redColor;
        
        _commodityImage.contentMode = UIViewContentModeScaleAspectFill;
        _commodityImage.clipsToBounds = YES;
        
        [self addSubview:self.commodityImage];
        [self addSubview:self.commodityName];
        [self addSubview:self.price];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        return [self initWithFrame:CGRectZero];
    }
    return self;
}

- (void)layoutSubviews {
    [self.commodityImage setFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    [self.commodityName setFrame:CGRectMake(0, 200, self.frame.size.width, 20)];
    [self.price setFrame:CGRectMake(0, 220, self.frame.size.width, 20)];
}

@end
