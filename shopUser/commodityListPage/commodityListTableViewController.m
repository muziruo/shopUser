//
//  commodityListTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "commodityListTableViewController.h"


@interface commodityListTableViewController ()

@property NSArray *commodityListInfo;
@property UIStoryboard *mainStoryBroad;

@end

@implementation commodityListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (self.searchText != nil) {
        [self searchInfo];
    }
    //self.hidesBottomBarWhenPushed = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//搜索商品
-(void)searchInfo {
    NSDictionary *params = [NSDictionary dictionaryWithObject:self.searchText forKey:@"keyWord"];
    [AVCloud callFunctionInBackground:@"searchCommodity" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.commodityListInfo = object;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.commodityListInfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    commodityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commodityListCel" forIndexPath:indexPath];

//    在此配置数据
    
    cell.commodityInfo.text = [self.commodityListInfo[indexPath.row] valueForKey:@"description"];
    cell.commodityName.text = [self.commodityListInfo[indexPath.row] valueForKey:@"name"];
    
    NSURL *imageUrl = [NSURL URLWithString:[self.commodityListInfo[indexPath.row] valueForKey:@"mainImage"]];
    [cell.commodityImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace"]];
    
    NSString *priceText = [NSNumberFormatter localizedStringFromNumber:[self.commodityListInfo[indexPath.row] valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
    cell.price.text = priceText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    infoViewController *nextView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityInfoView"];
    nextView.info = self.commodityListInfo[indexPath.row];
    [self.navigationController pushViewController:nextView animated:true];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
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
