//
//  collectionTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "collectionTableViewController.h"
#import "infoViewController.h"

@interface collectionTableViewController ()

@property NSMutableArray *collectionInfo;
@property UIStoryboard *mainStoryBroad;

@end

@implementation collectionTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self getCollectionInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//从网络获取收藏信息
-(void)getCollectionInfo {
    NSDictionary *params = [NSDictionary dictionaryWithObject:[AVUser currentUser].objectId forKey:@"userId"];
    [AVCloud callFunctionInBackground:@"getCollectionCommodity" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.collectionInfo = [object mutableCopy];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }else {
            NSLog(@"数据获取失败");
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.collectionInfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    collectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.commodityName.font = UIFont.normalFontLight;
    
//    请在此配置cell的数据
    cell.commodityName.text = [[self.collectionInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"name"];
    
    NSURL *imageUrl = [NSURL URLWithString:[[self.collectionInfo[indexPath.row] valueForKey:@"commodity"] valueForKey:@"mainImage"]];
    [cell.commodityImage sd_setImageWithURL:imageUrl];
    
    return cell;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *actionArray = [[NSMutableArray alloc] init];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSDictionary *params = @{@"collectionId":[self.collectionInfo[indexPath.row] valueForKey:@"objectId"]};
        [AVCloud callFunctionInBackground:@"deleteCollection" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            
        }];
        
        [self.collectionInfo removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    }];
    
    [actionArray addObject:deleteAction];
    
    return actionArray;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    infoViewController *infoView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityInfoView"];
    infoView.info = [self.collectionInfo[indexPath.row] valueForKey:@"commodity"];
    [self.navigationController pushViewController:infoView animated:true];
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
