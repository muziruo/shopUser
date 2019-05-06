//
//  waitShipTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/24.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "waitShipTableViewController.h"

@interface waitShipTableViewController ()

@end

@implementation waitShipTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getOrderInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)getOrderInfo {
    NSDictionary *params = @{
                             @"userId":[AVUser currentUser].objectId,
                             @"orderStatus":@1
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    orderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oderCell"];
    
    if (!cell) {
        cell = [[orderStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:[[self.orderInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"mainImage"]];
    [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
    cell.commodityName.text = [[self.orderInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"name"];
    cell.commodityShop.text = [[self.orderInfo[indexPath.row] valueForKey:@"shop"] valueForKey:@"name"];
    cell.commodityModel.text = [self.orderInfo[indexPath.row] valueForKey:@"commodityModel"];
    cell.commodityStatus.text = @"待发货";
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orderInfo count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
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
