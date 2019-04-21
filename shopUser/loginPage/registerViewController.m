//
//  registerViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()

@end

@implementation registerViewController

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
    
    self.verifiedCode = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(40, passwordLine.frame.origin.y + 30, self.accountInput.frame.size.width - 100, 50)];
    self.verifiedCode.placeholder = @"验证码";
    UIView *codeLine = [[UIView alloc] initWithFrame:CGRectMake(40, self.verifiedCode.frame.origin.y + 50, self.verifiedCode.frame.size.width, 1)];
    codeLine.backgroundColor = UIColor.blackColor;
    self.verifiedCode.floatingLabelTextColor = UIColor.themeMainColor;
    
    self.getCode = [[UIButton alloc] initWithFrame:CGRectMake(self.verifiedCode.frame.origin.x + self.verifiedCode.frame.size.width, self.verifiedCode.frame.origin.y, 100, 50)];
    [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCode.titleLabel setFont:UIFont.normalFontLight];
    [self.getCode setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.getCode.layer.cornerRadius = 25;
    self.getCode.backgroundColor = UIColor.themeMainColor;
    
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
    NSLog(@"注册成功");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

@end
