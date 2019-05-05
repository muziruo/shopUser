//
//  orderStatusTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/24.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "orderStatusTableViewCell.h"

@implementation orderStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //
        self.commodityImage = [[UIImageView alloc] init];
        self.commodityImage.contentMode = UIViewContentModeScaleAspectFit;
        //
        self.commodityName = [[UILabel alloc] init];
        self.commodityName.font = UIFont.normalFont;
        //
        self.commodityModel = [[UILabel alloc] init];
        self.commodityModel.font = UIFont.descriptionFontLight;
        //
        self.commodityShop = [[UILabel alloc] init];
        self.commodityShop.font = UIFont.descriptionFont;
        //
        self.commodityStatus = [[UILabel alloc] init];
        self.commodityStatus.font = UIFont.descriptionFont;
        self.commodityStatus.textColor = UIColor.stressColor;
        [self.commodityStatus setTextAlignment:NSTextAlignmentRight];
        //
        
        [self addSubview:self.commodityImage];
        [self addSubview:self.commodityName];
        [self addSubview:self.commodityModel];
        [self addSubview:self.commodityStatus];
        [self addSubview:self.commodityShop];
        
        //
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(20, 20, 0, 0);
        [self.commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imagePadding.top);
            make.left.equalTo(self.mas_left).with.offset(imagePadding.left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        //
        UIEdgeInsets namePadding = UIEdgeInsetsMake(20, 20, 0, -20);
        [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(namePadding.top);
            make.left.equalTo(self.commodityImage.mas_right).with.offset(namePadding.left);
            make.right.equalTo(self.mas_right).with.offset(namePadding.right);
        }];
        //
        UIEdgeInsets modelPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityModel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityName.mas_bottom).with.offset(modelPadding.top);
            make.right.equalTo(self.mas_right).with.offset(modelPadding.right);
            make.left.equalTo(self.commodityName.mas_left);
        }];
        //
        UIEdgeInsets shopPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityModel.mas_bottom).with.offset(shopPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(shopPadding.right);
        }];
        //
        UIEdgeInsets statusPadding = UIEdgeInsetsMake(10, 0, -20, -20);
        [self.commodityStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityShop.mas_bottom).with.offset(statusPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(statusPadding.right);
            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(statusPadding.bottom);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    
}

@end




@implementation waitReceiptCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        //
        self.commodityImage = [[UIImageView alloc] init];
        self.commodityImage.contentMode = UIViewContentModeScaleAspectFit;
        //
        self.commodityName = [[UILabel alloc] init];
        self.commodityName.font = UIFont.normalFont;
        //
        self.commodityModel = [[UILabel alloc] init];
        self.commodityModel.font = UIFont.descriptionFontLight;
        //
        self.commodityShop = [[UILabel alloc] init];
        self.commodityShop.font = UIFont.descriptionFont;
        //
        self.commodityStatus = [[UILabel alloc] init];
        self.commodityStatus.font = UIFont.descriptionFont;
        self.commodityStatus.textColor = UIColor.stressColor;
        [self.commodityStatus setTextAlignment:NSTextAlignmentRight];
        //
        self.sureReceipt = [[SUSelectButton alloc] init];
        [self.sureReceipt setTintColor:UIColor.whiteColor];
        self.sureReceipt.titleLabel.font = UIFont.descriptionFont;
        self.sureReceipt.backgroundColor = UIColor.stressColor;
        self.sureReceipt.titleLabel.font = UIFont.descriptionFont;
        self.sureReceipt.layer.cornerRadius = 12.5;
        [self.sureReceipt addTarget:self action:@selector(goToDelegate) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.commodityImage];
        [self addSubview:self.commodityName];
        [self addSubview:self.commodityModel];
        [self addSubview:self.commodityStatus];
        [self addSubview:self.commodityShop];
        [self addSubview:self.sureReceipt];
        
        //
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(20, 20, 0, 0);
        [self.commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imagePadding.top);
            make.left.equalTo(self.mas_left).with.offset(imagePadding.left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        //
        UIEdgeInsets namePadding = UIEdgeInsetsMake(20, 20, 0, -20);
        [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(namePadding.top);
            make.left.equalTo(self.commodityImage.mas_right).with.offset(namePadding.left);
            make.right.equalTo(self.mas_right).with.offset(namePadding.right);
        }];
        //
        UIEdgeInsets modelPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityModel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityName.mas_bottom).with.offset(modelPadding.top);
            make.right.equalTo(self.mas_right).with.offset(modelPadding.right);
            make.left.equalTo(self.commodityName.mas_left);
        }];
        //
        UIEdgeInsets shopPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityModel.mas_bottom).with.offset(shopPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(shopPadding.right);
        }];
        //
        UIEdgeInsets statusPadding = UIEdgeInsetsMake(10, 0, -20, -20);
        [self.commodityStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityShop.mas_bottom).with.offset(statusPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(statusPadding.right);
            //make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(statusPadding.bottom);
        }];
//
        UIEdgeInsets buttonPadding = UIEdgeInsetsMake(10, 0, -20, -20);
        [self.sureReceipt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityStatus.mas_bottom).with.offset(buttonPadding.top);
            make.right.equalTo(self.mas_right).with.offset(buttonPadding.right);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(buttonPadding.bottom);
        }];
    }

    return self;
}


-(void)goToDelegate {
    if ([self.sureReceipt.selectDelegate respondsToSelector:@selector(SUSelectButtonChangeStatus:)]) {
        [self.sureReceipt.selectDelegate SUSelectButtonChangeStatus:self.sureReceipt];
    }
}

@end



@implementation waitEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        //
        self.commodityImage = [[UIImageView alloc] init];
        self.commodityImage.contentMode = UIViewContentModeScaleAspectFit;
        //
        self.commodityName = [[UILabel alloc] init];
        self.commodityName.font = UIFont.normalFont;
        //
        self.commodityModel = [[UILabel alloc] init];
        self.commodityModel.font = UIFont.descriptionFontLight;
        //
        self.commodityShop = [[UILabel alloc] init];
        self.commodityShop.font = UIFont.descriptionFont;
        //
        self.commodityStatus = [[UILabel alloc] init];
        self.commodityStatus.font = UIFont.descriptionFont;
        self.commodityStatus.textColor = UIColor.stressColor;
        [self.commodityStatus setTextAlignment:NSTextAlignmentRight];
        //
        self.evaluate = [[SUSelectButton alloc] init];
        [self.evaluate setTintColor:UIColor.whiteColor];
        self.evaluate.titleLabel.font = UIFont.descriptionFont;
        self.evaluate.backgroundColor = UIColor.stressColor;
        self.evaluate.titleLabel.font = UIFont.descriptionFont;
        self.evaluate.layer.cornerRadius = 12.5;
        [self.evaluate addTarget:self action:@selector(goToDelegate) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.commodityImage];
        [self addSubview:self.commodityName];
        [self addSubview:self.commodityModel];
        [self addSubview:self.commodityStatus];
        [self addSubview:self.commodityShop];
        [self addSubview:self.evaluate];
        
        //
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(20, 20, 0, 0);
        [self.commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imagePadding.top);
            make.left.equalTo(self.mas_left).with.offset(imagePadding.left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        //
        UIEdgeInsets namePadding = UIEdgeInsetsMake(20, 20, 0, -20);
        [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(namePadding.top);
            make.left.equalTo(self.commodityImage.mas_right).with.offset(namePadding.left);
            make.right.equalTo(self.mas_right).with.offset(namePadding.right);
        }];
        //
        UIEdgeInsets modelPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityModel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityName.mas_bottom).with.offset(modelPadding.top);
            make.right.equalTo(self.mas_right).with.offset(modelPadding.right);
            make.left.equalTo(self.commodityName.mas_left);
        }];
        //
        UIEdgeInsets shopPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityModel.mas_bottom).with.offset(shopPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(shopPadding.right);
        }];
        //
        UIEdgeInsets statusPadding = UIEdgeInsetsMake(10, 0, -20, -20);
        [self.commodityStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityShop.mas_bottom).with.offset(statusPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(statusPadding.right);
            //make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(statusPadding.bottom);
        }];
        //
        UIEdgeInsets buttonPadding = UIEdgeInsetsMake(10, 0, -20, -20);
        [self.evaluate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityStatus.mas_bottom).with.offset(buttonPadding.top);
            make.right.equalTo(self.mas_right).with.offset(buttonPadding.right);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(buttonPadding.bottom);
        }];
        
    }

    return self;
}

//-(void)goToEvaluate {
//    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    evaluateViewController *evaluateView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"evaluateView"];
//    [[self getController].navigationController pushViewController:evaluateView animated:true];
//}


- (UIViewController *)getController {
    for (UIView *nextView =[self superview]; nextView; nextView = nextView.superview) {
        UIResponder *getResponder = [nextView nextResponder];
        if ([getResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)getResponder;
        }
    }
    return nil;
}


-(void)goToDelegate {
    if ([self.evaluate.selectDelegate respondsToSelector:@selector(SUSelectButtonChangeStatus:)]) {
        [self.evaluate.selectDelegate SUSelectButtonChangeStatus:self.evaluate];
    }
}

@end



@implementation historyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        //
        self.commodityImage = [[UIImageView alloc] init];
        self.commodityImage.contentMode = UIViewContentModeScaleAspectFit;
        //
        self.commodityName = [[UILabel alloc] init];
        self.commodityName.font = UIFont.normalFont;
        //
        self.commodityModel = [[UILabel alloc] init];
        self.commodityModel.font = UIFont.descriptionFontLight;
        //
        self.commodityShop = [[UILabel alloc] init];
        self.commodityShop.font = UIFont.descriptionFont;
        //
        self.commodityStatus = [[UILabel alloc] init];
        self.commodityStatus.font = UIFont.descriptionFont;
        self.commodityStatus.textColor = UIColor.themeMainColor;
        [self.commodityStatus setTextAlignment:NSTextAlignmentRight];
        //
        
        [self addSubview:self.commodityImage];
        [self addSubview:self.commodityName];
        [self addSubview:self.commodityModel];
        [self addSubview:self.commodityStatus];
        [self addSubview:self.commodityShop];
        
        //
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(20, 20, 0, 0);
        [self.commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imagePadding.top);
            make.left.equalTo(self.mas_left).with.offset(imagePadding.left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        //
        UIEdgeInsets namePadding = UIEdgeInsetsMake(20, 20, 0, -20);
        [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(namePadding.top);
            make.left.equalTo(self.commodityImage.mas_right).with.offset(namePadding.left);
            make.right.equalTo(self.mas_right).with.offset(namePadding.right);
        }];
        //
        UIEdgeInsets modelPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityModel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityName.mas_bottom).with.offset(modelPadding.top);
            make.right.equalTo(self.mas_right).with.offset(modelPadding.right);
            make.left.equalTo(self.commodityName.mas_left);
        }];
        //
        UIEdgeInsets shopPadding = UIEdgeInsetsMake(10, 20, 0, -20);
        [self.commodityShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityModel.mas_bottom).with.offset(shopPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(shopPadding.right);
        }];
        //
        UIEdgeInsets statusPadding = UIEdgeInsetsMake(10, 0, -20, -20);
        [self.commodityStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commodityShop.mas_bottom).with.offset(statusPadding.top);
            make.left.equalTo(self.commodityName.mas_left);
            make.right.equalTo(self.mas_right).with.offset(statusPadding.right);
            make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(statusPadding.bottom);
        }];
    }

    return self;
}

@end
