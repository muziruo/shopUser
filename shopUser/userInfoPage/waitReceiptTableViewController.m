//
//  waitReceiptTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/24.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "waitReceiptTableViewController.h"

@interface waitReceiptTableViewController ()

@end

@implementation waitReceiptTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getOrderInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)getOrderInfo {
    NSDictionary *params = @{
                             @"userId":@"5cbc81e6a3180b7832cd059a",
                             @"orderStatus":@2
                             };
    [AVCloud callFunctionInBackground:@"searchOrder" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([object valueForKey:@"success"]) {
                self.orderInfo = [object valueForKey:@"result"];
                [self.tableView reloadData];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orderInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    waitReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waitReceiptCell"];
    
    if (!cell) {
        cell = [[waitReceiptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waitReceiptCell"];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:[[self.orderInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"mainImage"]];
    [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
    cell.commodityName.text = [[self.orderInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"name"];
    cell.commodityShop.text = [[self.orderInfo[indexPath.row] valueForKey:@"shop"] valueForKey:@"name"];
    cell.commodityModel.text = [self.orderInfo[indexPath.row] valueForKey:@"commodityModel"];
    
    cell.commodityStatus.text = @"正在运输";
    [cell.sureReceipt setTitle:@"确认收货" forState:UIControlStateNormal];
    cell.sureReceipt.selectDelegate = self;
    cell.sureReceipt.tag = 101 + indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (void)SUSelectButtonChangeStatus:(SUSelectButton *)selectedButton {
    NSLog(@"待收货订单位于%ld",selectedButton.tag - 101);
    [SVProgressHUD show];
    NSDictionary *params = @{@"orderId":[self.orderInfo[selectedButton.tag - 101] valueForKey:@"objectId"],@"orderStatus":@3};
    [AVCloud callFunctionInBackground:@"shipOrder" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([[object valueForKey:@"success"] boolValue]) {
                [SVProgressHUD dismiss];
                [self getOrderInfo];
            }
        }
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
