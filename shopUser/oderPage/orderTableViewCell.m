//
//  orderTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/23.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderTableViewCell.h"

@implementation orderTableViewCell

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
        
//        收货人姓名
        self.receiptName = [[UILabel alloc] init];
        self.receiptName.font = UIFont.titleFont;
        self.receiptName.textColor = UIColor.themeMainColor;
        
        [self addSubview:self.receiptName];
        UIEdgeInsets receiptNamePadding = UIEdgeInsetsMake(10, 30, 0, -10);
        [self.receiptName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(receiptNamePadding.top);
            make.left.equalTo(self.mas_left).with.offset(receiptNamePadding.left);
        }];
        

//        是否默认
        self.isDefalut = [[UILabel alloc] init];
        self.isDefalut.font = UIFont.descriptionFont;
        self.isDefalut.textColor = UIColor.stressColor;
        [self addSubview:self.isDefalut];
        UIEdgeInsets isDefaultPadding = UIEdgeInsetsMake(10, 0, 0, -30);
        [self.isDefalut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(isDefaultPadding.top);
            make.right.equalTo(self.mas_right).with.offset(isDefaultPadding.right);
            make.width.mas_equalTo(40);
        }];
        
        
//        收货人电话
        self.receiptNumber = [[UILabel alloc] init];
        self.receiptNumber.font = UIFont.normalFont;
        self.receiptNumber.textColor = UIColor.themeMainColor;
        [self addSubview:self.receiptNumber];
        UIEdgeInsets numberPadding = UIEdgeInsetsMake(10, 30, 0, -30);
        [self.receiptNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.receiptName.mas_bottom).with.offset(numberPadding.top);
            make.left.equalTo(self.mas_left).with.offset(numberPadding.left);
            make.right.equalTo(self.mas_right).with.offset(numberPadding.right);
        }];
        
        
//        详细地址
        self.receiptLocal = [[UILabel alloc] init];
        self.receiptLocal.font = UIFont.descriptionFontLight;
        self.receiptLocal.numberOfLines = 0;
        [self addSubview:self.receiptLocal];
        UIEdgeInsets localPadding = UIEdgeInsetsMake(10, 30, -10, -30);
        [self.receiptLocal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.receiptNumber.mas_bottom).with.offset(localPadding.top);
            make.left.equalTo(self.mas_left).with.offset(localPadding.left);
            make.right.equalTo(self.mas_right).with.offset(localPadding.right);
            make.bottom.equalTo(self.mas_bottom).with.offset(localPadding.bottom);
        }];

    }
    
    return self;
}

@end



@implementation commodityInfoCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
//        商品图片
        self.commodityImage = [[UIImageView alloc] init];
        self.commodityImage.contentMode = UIViewContentModeScaleAspectFit;
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(10, 25, 0, 0);
        [self.commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
            <#code#>
        }];
        
        
//        商品名称
        self.commodityName = [[UILabel alloc] init];
        self.commodityName.font = UIFont.normalFont;
        UIEdgeInsets namePadding = UIEdgeInsetsMake(10, 10, 0, -25);
        [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            <#code#>
        }];
        
        
//        商品型号
        self.commodityModel = [[UILabel alloc] init];
        self.commodityModel.font = UIFont.descriptionFontLight;
        UIEdgeInsets modelPadding = UIEdgeInsetsMake(5, 10, 0, -25);
        [self.commodityModel mas_makeConstraints:^(MASConstraintMaker *make) {
            <#code#>
        }];
        
        
//        商品价格
        self.commodityPrice = [[UILabel alloc] init];
        self.commodityPrice.font = UIFont.normalFont;
        self.commodityPrice.textColor = UIColor.stressColor;
        UIEdgeInsets pricePadding = UIEdgeInsetsMake(5, 10, 0, -25);
        [self.commodityPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            <#code#>
        }];
        
        
//        
    }
    
    return self;
}


- (void)layoutSubviews {
    
}

@end
