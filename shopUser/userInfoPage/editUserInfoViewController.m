//
//  editUserInfoViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/5/15.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "editUserInfoViewController.h"

@interface editUserInfoViewController ()


@end

@implementation editUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editUserInfoTableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.saveButton addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    localEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editUserInfoCell"];
    
    if (!cell) {
        cell = [[localEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"editUserInfoCell"];
    }
    
    cell.infoTitle.text = @"昵称";
    
    cell.infoInput.text = [[AVUser currentUser] valueForKey:@"nickName"];
    
    cell.infoInput.tag = 101;
    
    return cell;
}

-(void)saveUserInfo {
    UITextField *inputName = [self.view viewWithTag:101];
    
    [[AVUser currentUser] setObject:inputName.text forKey:@"nickName"];
    
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error == nil) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [SVProgressHUD dismissWithDelay:0.8];
            if ([self.delegate respondsToSelector:@selector(refreshUserInfo)]) {
                [self.delegate refreshUserInfo];
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}


@end
