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
        UIEdgeInsets receiptNamePadding = UIEdgeInsetsMake(10, 30, 0, -20);
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
        [self addSubview:self.commodityImage];
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(20, 25, -20, 0);
        [self.commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imagePadding.top);
            make.left.equalTo(self.mas_left).with.offset(imagePadding.left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(imagePadding.bottom);
        }];
        
        
//        商品名称
        self.commodityName = [[UILabel alloc] init];
        self.commodityName.font = UIFont.normalFont;
        [self addSubview:self.commodityName];
        UIEdgeInsets namePadding = UIEdgeInsetsMake(20, 20, 0, -25);
        [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(namePadding.top);
            make.left.equalTo(self.commodityImage.mas_right).with.offset(namePadding.left);
            make.right.equalTo(self.mas_right).with.offset(namePadding.right);
        }];
        
        
//        商品型号
        self.commodityModel = [[UILabel alloc] init];
        self.commodityModel.font = UIFont.descriptionFontLight;
        [self addSubview:self.commodityModel];
        UIEdgeInsets modelPadding = UIEdgeInsetsMake(5, 20, 0, -25);
        [self.commodityModel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.commodityName.mas_left);
            make.top.equalTo(self.commodityName.mas_bottom).with.offset(modelPadding.top);
            make.right.equalTo(self.mas_right).with.offset(modelPadding.right);
        }];
        
        
//        商家名称
        self.shopName = [[UILabel alloc] init];
        self.shopName.font = UIFont.descriptionFont;
        [self addSubview:self.shopName];
        UIEdgeInsets shopPadding = UIEdgeInsetsMake(5, 20, 0, -25);
        [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.commodityName.mas_left);
            make.top.equalTo(self.commodityModel.mas_bottom).with.offset(shopPadding.top);
            make.right.equalTo(self.mas_right).with.offset(shopPadding.right);
        }];
        
        
//        商品价格
        self.commodityPrice = [[UILabel alloc] init];
        self.commodityPrice.font = UIFont.normalFont;
        self.commodityPrice.textColor = UIColor.stressColor;
        [self addSubview:self.commodityPrice];
        UIEdgeInsets pricePadding = UIEdgeInsetsMake(5, 20, 0, -25);
        [self.commodityPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(pricePadding.right);
            make.top.equalTo(self.shopName.mas_bottom).with.offset(pricePadding.top);
        }];
        
        
//        self.number = [[UILabel alloc] init];
//        self.number.font = UIFont.descriptionFontLight;
//        [self addSubview:self.number];
//        UIEdgeInsets numberPadding = UIEdgeInsetsMake(5, 0, -20, -25);
//        [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.commodityPrice.mas_bottom).with.offset(numberPadding.top);
//            make.left.equalTo(self.commodityName.mas_left);
//            make.right.equalTo(self.mas_right).with.offset(numberPadding.right);
//            make.bottom.equalTo(self.mas_bottom).with.offset(numberPadding.bottom);
//        }];
        
        
////        计数器区域
//        self.numberArea = [[UIView alloc] init];
//        self.numberArea.backgroundColor = UIColor.voidColor;
//        [self.contentView addSubview:self.numberArea];
//        UIEdgeInsets areaPadding = UIEdgeInsetsMake(10, 0, -20, -25);
//        [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).with.offset(areaPadding.right);
//            make.top.equalTo(self.commodityPrice.mas_bottom).with.offset(areaPadding.top);
//            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(areaPadding.bottom);
//            make.left.equalTo(self.commodityPrice.mas_left);
//            make.height.mas_equalTo(30);
//            make.width.mas_equalTo(100);
//        }];
        
        
//        数量增减器
        self.numberButton = [[PPNumberButton alloc] init];
        self.numberButton.borderColor = UIColor.themeMainColor;
        //self.numberButton.decreaseHide = YES;
        self.numberButton.currentNumber = 1;
        self.numberButton.minValue = 1;
        self.numberButton.increaseTitle = @"+";
        self.numberButton.decreaseTitle = @"-";
        [self addSubview:self.numberButton];
        UIEdgeInsets numberPadding = UIEdgeInsetsMake(10, 0, -20, -25);
        [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(numberPadding.right);
            make.top.equalTo(self.commodityPrice.mas_bottom).with.offset(numberPadding.top);
            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(numberPadding.bottom);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
    }
    
    return self;
}


- (void)layoutSubviews {
    
}

@end
