//
//  verifyCodeLoginViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/5/8.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "verifyCodeLoginViewController.h"

@interface verifyCodeLoginViewController ()

@property NSUserDefaults *userSetting;

@end

@implementation verifyCodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.userSetting = [NSUserDefaults standardUserDefaults];
    
    self.accountInput = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width - 80, 50)];
    UIView *accountLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.accountInput.frame.origin.y + 50, self.accountInput.frame.size.width, 1)];
    accountLine.backgroundColor = UIColor.blackColor;
    self.accountInput.placeholder = @"手机号";
    //    限制输入
    self.accountInput.keyboardType = UIKeyboardTypeNumberPad;
    self.accountInput.floatingLabelTextColor = UIColor.themeMainColor;
    
    
    
    self.passwordInput = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, accountLine.frame.origin.y + 30, self.accountInput.frame.size.width - 100, 50)];
    UIView *passwordLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.passwordInput.frame.origin.y + 50, self.passwordInput.frame.size.width, 1)];
    passwordLine.backgroundColor = UIColor.blackColor;
    self.passwordInput.placeholder = @"验证码";
    //    限制输入
    self.passwordInput.keyboardType = UIKeyboardTypeNumberPad;
    
    self.passwordInput.floatingLabelTextColor = UIColor.themeMainColor;
    
    
    
    self.getCode = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordInput.frame.origin.x + self.passwordInput.frame.size.width, self.passwordInput.frame.origin.y, 100, 50)];
    [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCode.titleLabel setFont:UIFont.normalFontLight];
    [self.getCode setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.getCode.layer.cornerRadius = 25;
    self.getCode.backgroundColor = UIColor.themeMainColor;
    [self.getCode addTarget:self action:@selector(getVerifiedCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height - 220, self.view.frame.size.width - 120, 50)];
    self.loginButton.layer.cornerRadius = 25;
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:UIFont.normalFont];
    self.loginButton.backgroundColor = UIColor.themeMainColor;
    self.loginButton.tintColor = UIColor.whiteColor;
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.accountInput];
    [self.view addSubview:self.passwordInput];
    [self.view addSubview:passwordLine];
    [self.view addSubview:accountLine];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.getCode];
    // Do any additional setup after loading the view.
}


- (UIView *)listView {
    return self.view;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


-(void)getVerifiedCode {
    NSString *phoneNumber = self.accountInput.text;
    if ([phoneNumber isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:0.8];
        return;
    }
    
    [AVSMS requestShortMessageForPhoneNumber:phoneNumber options:nil callback:^(BOOL succeeded, NSError * _Nullable error) {
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
}


-(void)login {
    [AVUser logInWithMobilePhoneNumberInBackground:self.accountInput.text smsCode:self.passwordInput.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        if (error == nil) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:1.0];
            [[self getCurrentVC] dismissViewControllerAnimated:true completion:nil];
        }else{
            if (error.code == 211) {
                [SVProgressHUD showErrorWithStatus:@"未找到用户"];
                [SVProgressHUD dismissWithDelay:1.0];
            }else if (error.code == 603){
                [SVProgressHUD showErrorWithStatus:@"无效的短信验证码"];
                [SVProgressHUD dismissWithDelay:1.0];
            }
        }
    }];
}


- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
