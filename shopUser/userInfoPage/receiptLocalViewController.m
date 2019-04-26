//
//  receiptLocalViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "receiptLocalViewController.h"

@interface receiptLocalViewController ()

@property NSArray *receiptLocalInfo;
@property UIStoryboard *mainStoryBroad;

@end

@implementation receiptLocalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.addLoacl.backgroundColor = UIColor.buttonColor;
    [self.addLoacl addTarget:self action:@selector(goToAddLocal) forControlEvents:UIControlEventTouchUpInside];
    
    [self getReceiptLocalInfo];
    // Do any additional setup after loading the view.
}


//请在此配置网络数据请求
- (void)getReceiptLocalInfo {
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"5cbc8182c8959c00751357ca" forKey:@"userId"];
    [AVCloud callFunctionInBackground:@"getReceiptLocal" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.localInfo = object;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.receiptLocalTableView reloadData];
            }];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.localInfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    receiptLocalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localCell"];
    
    if (!cell) {
        cell = [[receiptLocalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"localCell"];
    }
    
    if (indexPath.row == 0) {
        cell.isDefault.text = @"默认";
    }
    
    NSString *address = [[self.localInfo[indexPath.row] valueForKey:@"area"] stringByAppendingString:[self.localInfo[indexPath.row] valueForKey:@"address"]];
    cell.receiptLocal.text = address;
    cell.receiptName.text = [self.localInfo[indexPath.row] valueForKey:@"name"];
    cell.receiptNumber.text = [self.localInfo[indexPath.row] valueForKey:@"phoneNumber"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    localEditViewController *editView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"editLocalView"];
    editView.editLocalInfo = self.localInfo[indexPath.row];
    editView.editOrCreate = 1;
    [self.navigationController pushViewController:editView animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


-(void)goToAddLocal {
    localEditViewController *editView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"editLocalView"];
    editView.editOrCreate = 0;
    [self.navigationController pushViewController:editView animated:true];
}

@end
