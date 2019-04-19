//
//  homeCollectionViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "homeCollectionViewCell.h"

@implementation homeCollectionViewCell


//在此配置分类cell中的具体子视图
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.categoryName = [[UILabel alloc] init];
        self.categoryImage = [[UIImageView alloc] init];
        self.categoryImage.contentMode = UIViewContentModeScaleAspectFill;
        self.categoryImage.clipsToBounds = YES;
        self.categoryName.textAlignment = NSTextAlignmentCenter;
        self.categoryName.font = UIFont.descriptionFont;
        
        [self addSubview:self.categoryImage];
        [self addSubview:self.categoryName];
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

//在此配置子视图的位置和大小
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.categoryImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size
                                            .height - 20)];
    self.categoryName.frame = CGRectMake(0, self.frame.size
                                         .height - 20, self.frame.size.width, 20);
}

@end
