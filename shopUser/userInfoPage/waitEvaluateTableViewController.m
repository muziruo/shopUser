//
//  waitEvaluateTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/24.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "waitEvaluateTableViewController.h"

@interface waitEvaluateTableViewController ()

@end

@implementation waitEvaluateTableViewController

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
                             @"orderStatus":@3
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
    waitEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waitEvaluateCell"];
    
    if (!cell) {
        cell = [[waitEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waitEvaluateCell"];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:[[self.orderInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"mainImage"]];
    [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
    cell.commodityName.text = [[self.orderInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"name"];
    cell.commodityShop.text = [[self.orderInfo[indexPath.row] valueForKey:@"shop"] valueForKey:@"name"];
    cell.commodityModel.text = [self.orderInfo[indexPath.row] valueForKey:@"commodityModel"];
    
    cell.commodityStatus.text = @"等待评价";
    [cell.evaluate setTitle:@"填写评论" forState:UIControlStateNormal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
