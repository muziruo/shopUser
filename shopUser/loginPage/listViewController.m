//
//  listViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "listViewController.h"

@interface listViewController ()

@end

@implementation listViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)login {
    NSLog(@"登录成功");
}

@end
