//
//  orderStatusCollectionViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderStatusCollectionViewCell.h"

@implementation orderStatusCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        return [self initWithFrame:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.statusImage = [[UIImageView alloc] init];
        self.statusTitle = [[UILabel alloc] init];
        
        self.statusTitle.font = UIFont.descriptionFontLight;
        self.statusTitle.textAlignment = NSTextAlignmentCenter;
        self.statusImage.contentMode = UIViewContentModeScaleAspectFill;
        self.statusImage.clipsToBounds = YES;
        
        [self addSubview:self.statusTitle];
        [self addSubview:self.statusImage];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.statusImage setFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    [self.statusTitle setFrame:CGRectMake(0, 60, self.frame.size.width, 15)];
}

@end
