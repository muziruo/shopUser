//
//  baseInfoTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/19.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "baseInfoTableViewCell.h"

@implementation baseInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.infoLabel = [[UILabel alloc] init];
        [self addSubview:self.infoLabel];
    }
    
    return self;
}

//之后修改为约束，删除此处的固定位置
- (void)layoutSubviews {
    [self.infoLabel setFrame:CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end



@implementation commentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIView *superView = self;
        
        self.userAvator = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
        self.userAvator.contentMode = UIViewContentModeScaleAspectFill;
        self.userAvator.clipsToBounds = true;
        self.userAvator.layer.cornerRadius = 20;
        [self addSubview:self.userAvator];
        
        self.userNickName = [[UILabel alloc] init];
        self.userNickName.font = UIFont.normalFont;
        UIEdgeInsets namePadding = UIEdgeInsetsMake(20, 20, 0, -20);
        [self addSubview:self.userNickName];
        [self.userNickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userAvator.mas_right).with.offset(namePadding.left);
            make.right.equalTo(superView.mas_right).with.offset(namePadding.right);
            make.top.equalTo(superView.mas_top).with.offset(namePadding.top);
        }];
        
        self.commentInfo = [[UILabel alloc] init];
        self.commentInfo.numberOfLines = 0;
        self.commentInfo.font = UIFont.descriptionFont;
        UIEdgeInsets commentPadding = UIEdgeInsetsMake(20, 70, -20, -20);
        [self addSubview:self.commentInfo];
        [self.commentInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom).with.offset(commentPadding.bottom);
            make.top.equalTo(self.userNickName.mas_bottom).with.offset(commentPadding.top);
            make.left.equalTo(superView.mas_left).with.offset(commentPadding.left);
            make.right.equalTo(superView.mas_right).with.offset(commentPadding.right);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    
}

@end



@implementation buttonCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.seeMore = [[UIButton alloc] init];
        self.seeMore.backgroundColor = UIColor.themeMainColor;
        [self.seeMore setTitle:@"查看更多评论" forState:UIControlStateNormal];
        self.seeMore.layer.cornerRadius = 10;
        self.seeMore.titleLabel.font = UIFont.descriptionFontLight;
        [self addSubview:self.seeMore];
        
        UIEdgeInsets buttonPadding = UIEdgeInsetsMake(5, 100, 5, 100);
        [self.seeMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(buttonPadding);
            make.height.mas_equalTo(20);
        }];
    }
    
    return self;
}

@end
