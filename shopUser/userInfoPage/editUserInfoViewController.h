//
//  editUserInfoViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/5/15.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "receiptLocalTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@protocol editUserInfoViewControllerDelegate <NSObject>

-(void)refreshUserInfo;

@end

@interface editUserInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *editUserInfoTableview;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic, weak) id<editUserInfoViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
