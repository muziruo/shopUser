//
//  registerViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()

@property NSUserDefaults *userSetting;
@property NSString *userId;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userSetting = [NSUserDefaults standardUserDefaults];
    
    self.accountInput = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width - 80, 50)];
    UIView *accountLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.accountInput.frame.origin.y + 50, self.accountInput.frame.size.width, 1)];
    accountLine.backgroundColor = UIColor.blackColor;
    self.accountInput.placeholder = @"手机号";
    
    self.accountInput.keyboardType = UIKeyboardTypeNumberPad;
    
    self.accountInput.floatingLabelTextColor = UIColor.themeMainColor;
    
    self.passwordInput = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, accountLine.frame.origin.y + 30, self.accountInput.frame.size.width, 50)];
    UIView *passwordLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.passwordInput.frame.origin.y + 50, self.accountInput.frame.size.width, 1)];
    passwordLine.backgroundColor = UIColor.blackColor;
    self.passwordInput.placeholder = @"密码";
    
    self.passwordInput.keyboardType = UIKeyboardTypeAlphabet;
    
    self.passwordInput.floatingLabelTextColor = UIColor.themeMainColor;
    
    self.verifiedCode = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, passwordLine.frame.origin.y + 30, self.accountInput.frame.size.width - 100, 50)];
    self.verifiedCode.placeholder = @"验证码";
    UIView *codeLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.verifiedCode.frame.origin.y + 50, self.verifiedCode.frame.size.width, 1)];
    codeLine.backgroundColor = UIColor.blackColor;
    
    self.verifiedCode.keyboardType = UIKeyboardTypeNumberPad;
    
    self.verifiedCode.floatingLabelTextColor = UIColor.themeMainColor;
    
    self.getCode = [[UIButton alloc] initWithFrame:CGRectMake(self.verifiedCode.frame.origin.x + self.verifiedCode.frame.size.width, self.verifiedCode.frame.origin.y, 100, 50)];
    [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCode.titleLabel setFont:UIFont.normalFontLight];
    [self.getCode setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.getCode.layer.cornerRadius = 25;
    self.getCode.backgroundColor = UIColor.themeMainColor;
    [self.getCode addTarget:self action:@selector(getVerifiedCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height - 220, self.view.frame.size.width - 120, 50)];
    self.registerButton.layer.cornerRadius = 25;
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.registerButton.titleLabel setFont:UIFont.normalFont];
    self.registerButton.backgroundColor = UIColor.themeMainColor;
    self.registerButton.tintColor = UIColor.whiteColor;
    [self.registerButton addTarget:self action:@selector(registerWork) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.accountInput];
    [self.view addSubview:self.passwordInput];
    [self.view addSubview:passwordLine];
    [self.view addSubview:accountLine];
    [self.view addSubview:self.verifiedCode];
    [self.view addSubview:codeLine];
    [self.view addSubview:self.getCode];
    [self.view addSubview:self.registerButton];
    
    // Do any additional setup after loading the view.
}


- (UIView *)listView {
    return self.view;
}


-(void)registerWork {
    if ([self.accountInput.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:0.8];
        return;
    }
    if ([self.passwordInput.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [SVProgressHUD dismissWithDelay:0.8];
        return;
    }
    if ([self.verifiedCode.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        [SVProgressHUD dismissWithDelay:0.8];
        return;
    }
    
    
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:self.accountInput.text smsCode:self.verifiedCode.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        if (error == nil) {
            self.userId = user.objectId;
            NSLog(@"获取的用户ID为%@",self.userId);
            
            [[AVUser currentUser] setObject:self.passwordInput.text forKey:@"password"];
            [[AVUser currentUser] setObject:@"未命名" forKey:@"nickName"];
            [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error == nil) {
                    [SVProgressHUD showSuccessWithStatus:@"已注册成功"];
                    [SVProgressHUD dismissWithDelay:1.0];
                    [[self getCurrentVC] dismissViewControllerAnimated:true completion:nil];
                }
            }];
        }else {
            if (error.code == 603) {
                [SVProgressHUD showErrorWithStatus:@"验证码错误"];
                [SVProgressHUD dismissWithDelay:1.0];
            }else if (error.code == 127){
                [SVProgressHUD showErrorWithStatus:@"无效的手机号"];
                [SVProgressHUD dismissWithDelay:1.0];
            }
        }
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}


-(void)getVerifiedCode {
    NSString *phoneNumber = self.accountInput.text;
    if ([phoneNumber isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:0.8];
        return;
    }
    
    [AVSMS requestShortMessageForPhoneNumber:phoneNumber options:nil callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (error == nil) {
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            [SVProgressHUD dismissWithDelay:0.5];
        }else {
            if (error.code == 127) {
                [SVProgressHUD showErrorWithStatus:@"无效的手机号"];
                [SVProgressHUD dismissWithDelay:0.8];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请检查手机号码格式"];
                [SVProgressHUD dismissWithDelay:0.8];
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
