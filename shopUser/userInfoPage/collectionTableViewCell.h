//
//  collectionTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface collectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commodityImage;
@property (weak, nonatomic) IBOutlet UILabel *commodityName;


@end

NS_ASSUME_NONNULL_END
