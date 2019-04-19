//
//  shoppingCarTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "shoppingCarTableViewCell.h"

@implementation shoppingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _commodityName.font = UIFont.normalFont;
    _descriptionInfo.font = UIFont.descriptionFont;
    _price.font = UIFont.numberFont;
    _commodityImage.contentMode = UIViewContentModeScaleAspectFill;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
