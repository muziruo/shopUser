//
//  receiptLocalTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "receiptLocalTableViewCell.h"

@implementation receiptLocalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.receiptName = [[UILabel alloc] init];
        self.receiptName.font = UIFont.titleFont;
        self.receiptName.textColor = UIColor.themeMainColor;
        [self addSubview:self.receiptName];
        UIEdgeInsets namePadding = UIEdgeInsetsMake(10, 20, 0, 0);
        [self.receiptName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(namePadding.top);
            make.left.equalTo(self.mas_left).with.offset(namePadding.left);
            make.width.mas_equalTo(100);
        }];
        
        self.receiptNumber = [[UILabel alloc] init];
        self.receiptNumber.font = UIFont.normalFont;
        self.receiptNumber.textColor = UIColor.themeMainColor;
        [self addSubview:self.receiptNumber];
        UIEdgeInsets numberPadding = UIEdgeInsetsMake(10, 10, 0, 0);
        [self.receiptNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(numberPadding.top);
            make.left.equalTo(self.receiptName.mas_right).with.offset(numberPadding.left);
            make.width.mas_equalTo(100);
        }];
        
        self.isDefault = [[UILabel alloc] init];
        self.isDefault.font = UIFont.descriptionFont;
        self.isDefault.textColor = UIColor.redColor;
        [self addSubview:self.isDefault];
        UIEdgeInsets defaultPadding = UIEdgeInsetsMake(10, 0, 0, -20);
        [self.isDefault mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(defaultPadding.right);
            make.top.equalTo(self.mas_top).with.offset(defaultPadding.top);
            make.width.mas_equalTo(30);
        }];
        
        self.receiptLocal = [[UILabel alloc] init];
        self.receiptLocal.font = UIFont.descriptionFontLight;
        [self addSubview:self.receiptLocal];
        UIEdgeInsets localPadding = UIEdgeInsetsMake(10, 20, -10, -20);
        [self.receiptLocal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.receiptName.mas_bottom).with.offset(localPadding.top);
            make.left.equalTo(self.mas_left).with.offset(localPadding.left);
            make.bottom.equalTo(self.mas_bottom).with.offset(localPadding.bottom);
            make.right.equalTo(self.mas_right).with.offset(localPadding.right);
        }];
        self.receiptLocal.numberOfLines = 0;
    }
    
    return self;
}

@end


@implementation localEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.infoTitle = [[UILabel alloc] init];
        self.infoTitle.font = UIFont.normalFontLight;
        [self addSubview:self.infoTitle];
        UIEdgeInsets titlePadding = UIEdgeInsetsMake(15, 30, -15, 0);
        [self.infoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(titlePadding.top);
            make.left.equalTo(self.mas_left).with.offset(titlePadding.left);
            make.width.mas_equalTo(60);
            make.height.mas_greaterThanOrEqualTo(40);
        }];
        
        self.infoInput = [[UITextField alloc] init];
        self.infoInput.font = UIFont.normalFont;
        self.infoInput.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self addSubview:self.infoInput];
        UIEdgeInsets inputPadding = UIEdgeInsetsMake(15, 20, -15, -20);
        [self.infoInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(inputPadding.top);
            make.left.equalTo(self.infoTitle.mas_right).with.offset(inputPadding.left);
            make.right.equalTo(self.mas_right).with.offset(inputPadding.right);
            make.bottom.equalTo(self.mas_bottom).with.offset(inputPadding.bottom);
            make.height.mas_greaterThanOrEqualTo(40);
        }];
    }
    
    return self;
}

@end
