//
//  userInfoTableViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userInfoTableViewCell.h"
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import "loginViewController.h"
#import "collectionTableViewController.h"
#import "receiptLocalViewController.h"
#import "editUserInfoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface userInfoTableViewController : UITableViewController<editUserInfoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatorimage;
@property (weak, nonatomic) IBOutlet UIView *userBackgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *userNickName;


@end

NS_ASSUME_NONNULL_END
