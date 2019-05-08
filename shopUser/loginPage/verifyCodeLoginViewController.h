//
//  verifyCodeLoginViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/5/8.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "JVFloatLabeledTextField.h"
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <AVOSCloud/AVOSCloud.h>
#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface verifyCodeLoginViewController : UIViewController<JXCategoryListContentViewDelegate>

@property JVFloatLabeledTextField *accountInput;
@property JVFloatLabeledTextField *passwordInput;
@property UIButton *getCode;
@property UIButton *loginButton;

@end

NS_ASSUME_NONNULL_END
