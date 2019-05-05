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
    self.editPlaceHolder = @[@"请输入收件人姓名",@"请输入手机号码",@"请选择所在区域",@"请输入具体住址"];
    self.needInfo = @[@"name",@"phoneNumber",@"area",@"address"];
    
    self.saveButton.backgroundColor = UIColor.buttonColor;
    
    UITapGestureRecognizer *tableviewEndEdit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    tableviewEndEdit.cancelsTouchesInView = NO;
    [self.localEditTableView addGestureRecognizer:tableviewEndEdit];
    
    self.localEditTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
        
        return cell;
    }
    
    localEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localEditCell"];
    
    if (!cell) {
        cell = [[localEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localEditCell"];
    }
    
    cell.infoTitle.text = self.editInfoTitle[indexPath.row];
    cell.infoInput.placeholder = self.editPlaceHolder[indexPath.row];
    
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

@end
