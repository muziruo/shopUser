//
//  orderDetailTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/25.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderDetailTableViewCell.h"

@implementation orderDetailTableViewCell

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
//
        self.orderIdTitle = [[UILabel alloc] init];
        self.orderIdTitle.font = UIFont.descriptionFont;
//
        self.orderId = [[UILabel alloc] init];
        self.orderId.font = UIFont.descriptionFontLight;
//
        self.orderSubmitTimeTitle = [[UILabel alloc] init];
        self.orderSubmitTimeTitle.font = UIFont.descriptionFont;
//
        self.orderSubmitTime = [[UILabel alloc] init];
        self.orderSubmitTime.font = UIFont.descriptionFontLight;
//
        self.orderReceiptTimeTitle = [[UILabel alloc] init];
        self.orderReceiptTimeTitle.font = UIFont.descriptionFont;
//
        self.orderReceiptTime = [[UILabel alloc] init];
        self.orderReceiptTime.font = UIFont.descriptionFontLight;
        
        
//
        [self addSubview:self.orderIdTitle];
        [self addSubview:self.orderId];
        [self addSubview:self.orderSubmitTimeTitle];
        [self addSubview:self.orderReceiptTime];
        [self addSubview:self.orderSubmitTime];
        [self addSubview:self.orderReceiptTimeTitle];
        
        
//
        UIEdgeInsets idTitlePadding = UIEdgeInsetsMake(20, 20, 0, 0);
        [self.orderIdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(idTitlePadding.top);
            make.left.equalTo(self.mas_left).with.offset(idTitlePadding.left);
            make.width.mas_equalTo(80);
        }];
        
//
        UIEdgeInsets idPadding = UIEdgeInsetsMake(20, 10, 0, -20);
        [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(idPadding.top);
            make.left.equalTo(self.orderIdTitle.mas_right).with.offset(idPadding.left);
            make.right.equalTo(self.mas_right).with.offset(idPadding.right);
        }];
//
        UIEdgeInsets submitTitle = UIEdgeInsetsMake(10, 20, 0, 0);
        [self.orderSubmitTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderIdTitle.mas_bottom).with.offset(submitTitle.top);
            make.left.equalTo(self.mas_left).with.offset(submitTitle.left);
            make.width.mas_equalTo(80);
        }];
//
        //UIEdgeInsets submitPadding = UIEdgeInsetsMake(10, 10, 0, -20);
        [self.orderSubmitTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderSubmitTimeTitle.mas_top);
            make.left.equalTo(self.orderId.mas_left);
            make.right.equalTo(self.orderId.mas_right);
        }];
//
        UIEdgeInsets receiptTitlePadding = UIEdgeInsetsMake(10, 20, -20, 0);
        [self.orderReceiptTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(receiptTitlePadding.bottom);
            make.top.equalTo(self.orderSubmitTime.mas_bottom).with.offset(receiptTitlePadding.top);
            make.left.equalTo(self.orderIdTitle.mas_left);
            make.width.mas_equalTo(80);
        }];
        
        [self.orderReceiptTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderReceiptTimeTitle.mas_top);
            make.left.equalTo(self.orderId.mas_left);
            make.right.equalTo(self.orderId.mas_right);
        }];
        
    }
    
    return self;
}

@end
