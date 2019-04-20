//
//  homeTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "homeTableViewController.h"


@interface homeTableViewController ()

@property NSArray *commodityInfo;

@end


@implementation homeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _logoImage.image = [UIImage imageNamed:@"zhanweitu.png"];
    
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    
    [self getHomeCommodity];
}

//获取云端数据
- (void)getHomeCommodity {
    [AVCloud callFunctionInBackground:@"getHomeCommodity" withParameters:nil block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.commodityInfo = object;
            //NSLog(@"数组中的元素个数为%lu",[object count]);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
            NSLog(@"数据获取成功");
        }
    }];
}


/**
 配置tableview
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + [self.commodityInfo count] / 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 2) {
        return 250;
    }
    return 200;
}

/**
 根据主页不同的sectiona来配置不同的cell，请在此处向子类传递数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        homePageTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"homePageTableViewCell"];
        //代码构建cell需要有这一步判断
        if (!myCell) {
            myCell = [[homePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homePageTableViewCell"];
        }
        return myCell;
    }else if (indexPath.section == 1){
        homeCategoryCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"homeCategoryCell"];
        if (!myCell) {
            myCell = [[homeCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCategoryCell"];
        }
        return myCell;
    }else {
        commodityCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"homeCommodityCell"];
        if (!myCell) {
            myCell = [[commodityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCommodityCell"];
        }
        myCell.commodityInfo = self.commodityInfo;
        myCell.backgroundColor = [[UIColor alloc] initWithRed:231 green:231 blue:231 alpha:1.0];
        return myCell;
    }
}

//section之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}

- (IBAction)goToSearch:(id)sender {
    NSArray *hotSearch = @[@"iPhone",@"iPad",@"MacBook",@"AirPods"];
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSearch searchBarPlaceholder:@"搜索您想要的商品" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        commodityListTableViewController *toController = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityListTableView"];
        [searchViewController.navigationController pushViewController:toController animated:YES];
    }];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:true completion:nil];
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
