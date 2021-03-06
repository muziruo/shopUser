//
//  evaluateViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/26.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "evaluateViewController.h"

@interface evaluateViewController ()

@property NSUserDefaults *userSetting;

@end

@implementation evaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"当前商品ID%@",[[self.orderInfo valueForKey:@"commodity"] valueForKey:@"objectId"]);
    
    self.view.backgroundColor = UIColor.voidColor;
    
    self.score = @5;
    
    self.stars = [[GRStarsView alloc] initWithStarSize:CGSizeMake(40, 40) margin:10 numberOfStars:5];
    self.stars.allowDecimal = NO;
    [self.scoreArea addSubview:self.stars];
    self.scoreArea.backgroundColor = UIColor.clearColor;
    
    __weak typeof(self)weakSelf = self;
    self.stars.touchedActionBlock = ^(CGFloat score) {
        weakSelf.score = [NSNumber numberWithFloat:score];
        NSLog(@"当前选择的分数:%@",weakSelf.score);
    };
    
    [self.submitButton addTarget:self action:@selector(submitEvaluate) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


-(void)submitEvaluate {
    [SVProgressHUD showWithStatus:@"正在提交"];
    
    self.userSetting = [NSUserDefaults standardUserDefaults];
    NSString *userInfoId = [self.userSetting valueForKey:@"userInfoId"];
    
    NSLog(@"该用户信息表Id为%@",userInfoId);
    
    NSString *info = self.inputInfo.text;
    if (info != nil) {
        NSDictionary *params = @{@"commodityId":[[self.orderInfo valueForKey:@"commodity"] valueForKey:@"objectId"],@"info":info,@"score":self.score,@"userId":[AVUser currentUser].objectId};
        [AVCloud callFunctionInBackground:@"addEvaluate" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"添加成功");
                
                NSDictionary *params = @{@"orderId":[self.orderInfo valueForKey:@"objectId"],@"orderStatus":@4};
                [AVCloud callFunctionInBackground:@"shipOrder" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
                    
                }];
                
                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                [SVProgressHUD dismissWithDelay:0.5];
                [self.navigationController popViewControllerAnimated:true];
            }
        }];
        
    }
}

@end
