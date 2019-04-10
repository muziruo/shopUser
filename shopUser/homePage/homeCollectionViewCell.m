//
//  homeCollectionViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "homeCollectionViewCell.h"

@implementation homeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.categoryName = [[UILabel alloc] init];
        self.categoryImage = [[UIImageView alloc] init];
        
        [self addSubview:self.categoryImage];
        [self addSubview:self.categoryName];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.categoryImage setFrame:CGRectMake(0, 0, self.frame.size.width - 5, self.frame.size
                                            .height - 5)];
    
}

@end
