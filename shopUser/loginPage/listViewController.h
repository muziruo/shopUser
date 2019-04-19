//
//  listViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "JVFloatLabeledTextField.h"
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"

NS_ASSUME_NONNULL_BEGIN

@interface listViewController : UIViewController<JXCategoryListContentViewDelegate>

@property JVFloatLabeledTextField *accountInput;
@property JVFloatLabeledTextField *passwordInput;
@property UIButton *loginButton;

@end

NS_ASSUME_NONNULL_END
