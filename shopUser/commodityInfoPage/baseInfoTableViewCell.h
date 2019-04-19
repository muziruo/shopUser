//
//  baseInfoTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/19.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"

NS_ASSUME_NONNULL_BEGIN

@interface baseInfoTableViewCell : UITableViewCell

@property UILabel* infoLabel;

@end


@interface commentTableViewCell : UITableViewCell

@property UIImageView *userAvator;
@property UILabel *userNickName;
@property UILabel *commentInfo;

@end

NS_ASSUME_NONNULL_END
