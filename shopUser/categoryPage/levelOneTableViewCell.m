//
//  levelOneTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "levelOneTableViewCell.h"

@implementation levelOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.categoryTitle.font = UIFont.normalFont;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
