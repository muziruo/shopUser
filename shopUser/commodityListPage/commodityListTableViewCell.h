//
//  commodityListTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface commodityListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commodityImage;
@property (weak, nonatomic) IBOutlet UILabel *commodityName;
@property (weak, nonatomic) IBOutlet UILabel *commodityInfo;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

NS_ASSUME_NONNULL_END
