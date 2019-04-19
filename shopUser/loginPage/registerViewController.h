//
//  registerViewController.h
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

@interface registerViewController : UIViewController<JXCategoryListContentViewDelegate>

@property JVFloatLabeledTextField *accountInput;
@property JVFloatLabeledTextField *passwordInput;
@property JVFloatLabeledTextField *verifiedCode;
@property UIButton *getCode;
@property UIButton *registerButton;

@end

NS_ASSUME_NONNULL_END
