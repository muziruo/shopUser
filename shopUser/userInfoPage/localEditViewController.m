//
//  localEditViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "localEditViewController.h"

@interface localEditViewController ()

@property NSArray *editInfoTitle;
@property NSArray *editPlaceHolder;
@property NSArray *needInfo;

@end

@implementation localEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editInfoTitle = @[@"收件人",@"电话号码",@"所在区域",@"具体住址"];
    self.editPlaceHolder = @[@"请输入收件人姓名(必填)",@"请输入手机号码(必填)",@"请选择所在区域(必填)",@"请输入具体住址(必填)"];
    self.needInfo = @[@"name",@"phoneNumber",@"area",@"address"];
    
    self.saveButton.backgroundColor = UIColor.buttonColor;
    
    UITapGestureRecognizer *tableviewEndEdit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    tableviewEndEdit.cancelsTouchesInView = NO;
    [self.localEditTableView addGestureRecognizer:tableviewEndEdit];
    
    self.localEditTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.saveButton addTarget:self action:@selector(saveLocalInfo) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.editInfoTitle count];
    if ([[self.editLocalInfo valueForKey:@"isDefault"] isEqual:@1]) {
        return [self.editInfoTitle count];
    }
    return [self.editInfoTitle count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.editInfoTitle count]) {
        defaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
        
        if (!cell) {
            cell = [[defaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
        }
        
        cell.defaultSwitch.tag = 777;
        
        return cell;
    }
    
    localEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localEditCell"];
    
    if (!cell) {
        cell = [[localEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localEditCell"];
    }
    
    cell.infoTitle.text = self.editInfoTitle[indexPath.row];
    cell.infoInput.placeholder = self.editPlaceHolder[indexPath.row];
    cell.infoInput.tag = 101 + indexPath.row;
    
    if (self.editOrCreate == 1) {
        cell.infoInput.text = [self.editLocalInfo valueForKey:self.needInfo[indexPath.row]];
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (void)endEdit {
    [self.view endEditing:YES];
}


//保存地址信息操作
-(void)saveLocalInfo {
    
//    获取信息
    UITextField *nameInput = [self.view viewWithTag:101];
    UITextField *phoneInput = [self.view viewWithTag:102];
    UITextField *areaInput = [self.view viewWithTag:103];
    UITextField *addressInput = [self.view viewWithTag:104];
    UISwitch *defaultSwitch = [self.view viewWithTag:777];
    
//    判空
    if ([nameInput.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人名称"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if ([phoneInput.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人电话"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if ([areaInput.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人地址"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if ([addressInput.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人地址"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
//    修改地址信息
    if (self.editOrCreate == 1) {
        NSNumber *defaultNumber = [[NSNumber alloc] init];
        if (defaultSwitch != nil) {
            if ([defaultSwitch isOn]) {
                defaultNumber = @1;
            }else {
                defaultNumber = @0;
            }
        }else {
            defaultNumber = @0;
        }
        
        NSDictionary *params = @{@"localId":[self.editLocalInfo valueForKey:@"objectId"],
                                 @"userId":[AVUser currentUser].objectId,
                                 @"name":nameInput.text,
                                 @"phoneNumber":phoneInput.text,
                                 @"area":areaInput.text,
                                 @"address":addressInput.text,
                                 @"isDefault":defaultNumber
                                 };
        
        [AVCloud callFunctionInBackground:@"resetReceiptLocalInfo" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([[object valueForKey:@"success"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    [SVProgressHUD dismissWithDelay:0.8];
                    [self.navigationController popViewControllerAnimated:true];
                }
            }
        }];
        
        
    }else if (self.editOrCreate == 0){
//        创建地址信息
        NSNumber *defaultNumber = [[NSNumber alloc] init];
        if (defaultSwitch != nil) {
            if ([defaultSwitch isOn]) {
                defaultNumber = @1;
            }else {
                defaultNumber = @0;
            }
        }
//        若为第一次添加，则必定设置为默认
        if (self.isFrist) {
            defaultNumber = @1;
        }
        
        NSDictionary *params = @{@"userId":[AVUser currentUser].objectId,
                                 @"name":nameInput.text,
                                 @"phoneNumber":phoneInput.text,
                                 @"area":areaInput.text,
                                 @"address":addressInput.text,
                                 @"isDefault":defaultNumber
                                 };
        
        [AVCloud callFunctionInBackground:@"setLocalInfo" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([[object valueForKey:@"success"] boolValue]) {
                    if ([defaultNumber  isEqual: @1]) {
                        NSDictionary *setParams = @{@"userLoginId":[AVUser currentUser].objectId,@"localId":[[object valueForKey:@"result"] valueForKey:@"objectId"]};
                        [AVCloud callFunctionInBackground:@"setLocalDefault" withParameters:setParams block:^(id  _Nullable object, NSError * _Nullable error) {
                            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                            [SVProgressHUD dismissWithDelay:0.8];
                            if ([self.delegate respondsToSelector:@selector(addedLocal)]) {
                                [self.delegate addedLocal];
                            }
                            [self.navigationController popViewControllerAnimated:true];
                        }];
                    }else {
                        if ([self.delegate respondsToSelector:@selector(addedLocal)]) {
                            [self.delegate addedLocal];
                        }
                        [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                        [SVProgressHUD dismissWithDelay:0.8];
                        [self.navigationController popViewControllerAnimated:true];
                    }
                }
            }
        }];
    }
}

@end
