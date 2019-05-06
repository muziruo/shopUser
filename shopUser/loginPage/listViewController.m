//
//  listViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "listViewController.h"

@interface listViewController ()

@property NSUserDefaults *userSetting;

@end

@implementation listViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userSetting = [NSUserDefaults standardUserDefaults];
    
    self.accountInput = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width - 80, 50)];
    UIView *accountLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.accountInput.frame.origin.y + 50, self.accountInput.frame.size.width, 1)];
    accountLine.backgroundColor = UIColor.blackColor;
    self.accountInput.placeholder = @"手机号";
    self.accountInput.floatingLabelTextColor = UIColor.themeMainColor;
    
    self.passwordInput = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, accountLine.frame.origin.y + 30, self.accountInput.frame.size.width, 50)];
    UIView *passwordLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.passwordInput.frame.origin.y + 50, self.accountInput.frame.size.width, 1)];
    passwordLine.backgroundColor = UIColor.blackColor;
    self.passwordInput.placeholder = @"密码";
    self.passwordInput.floatingLabelTextColor = UIColor.themeMainColor;
    
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
    // Do any additional setup after loading the view.
}

- (UIView *)listView {
    return self.view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//请在此配置具体的网络登录操作
- (void)login {
//    网络登录操作
    [AVUser logInWithMobilePhoneNumberInBackground:self.accountInput.text password:self.passwordInput.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        if (error == nil) {
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:1.0];
            [[self getCurrentVC] dismissViewControllerAnimated:true completion:nil];
            
//            NSDictionary *params = @{@"userLoginId":[AVUser currentUser].objectId};
//            [AVCloud callFunctionInBackground:@"getUserInfo" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
//                //[self.userSetting setObject:[object valueForKey:@"objectId"] forKey:@"userInfoId"];
//                [self.userSetting setValue:[[object valueForKey:@"result"][0] valueForKey:@"objectId"] forKey:@"userInfoId"];
//                NSLog(@"用户信息表id%@",[self.userSetting valueForKey:@"userInfoId"]);
//                //[self.userSetting synchronize];
//                
//            }];
            
        }
    }];
    
    //[self.userSetting setBool:true forKey:@"isLogin"];
    
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
