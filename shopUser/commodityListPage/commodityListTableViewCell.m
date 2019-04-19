//
//  commodityListTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "commodityListTableViewCell.h"

@implementation commodityListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commodityName.font = UIFont.normalFont;
    self.commodityInfo.font = UIFont.descriptionFontLight;
    self.price.font = UIFont.numberFont;
    
    self.commodityImage.contentMode = UIViewContentModeScaleAspectFill;
    self.commodityImage.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
