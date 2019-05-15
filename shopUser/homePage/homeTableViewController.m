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
@property NSNumber *page;

@end


@implementation homeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont navTitleFont], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _logoImage.image = [UIImage imageNamed:@"zhanweitu.png"];
    
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeCommodity)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreHomeCommodity)];
    
    self.page = @1;
    
    //[self getHomeCommodity];
    [self.tableView.mj_header beginRefreshing];
}



//获取云端数据
- (void)getHomeCommodity {
    
    NSDictionary *params = @{
                             @"page":@0
                             };
    [AVCloud callFunctionInBackground:@"getHomeCommodity" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([[object valueForKey:@"success"] boolValue]) {
                self.commodityInfo = [object valueForKey:@"result"];
                self.page = @1;
                
                //NSLog(@"数组中的元素个数为%lu",[object count]);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView reloadData];
                }];
                NSLog(@"数据获取成功");
            }else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView reloadData];
                }];
                [SVProgressHUD showErrorWithStatus:@"数据获取失败，请重新刷新"];
                [SVProgressHUD dismissWithDelay:2.0];
            }
        }else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
            }];
            [SVProgressHUD showErrorWithStatus:@"数据获取失败，请重新刷新"];
            [SVProgressHUD dismissWithDelay:2.0];
        }
    }];
}


//获取更多云端数据
- (void)getMoreHomeCommodity {
    
    NSDictionary *params = @{
                             @"page":self.page
                             };
    [AVCloud callFunctionInBackground:@"getHomeCommodity" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([object valueForKey:@"success"]) {
                [self.commodityInfo arrayByAddingObjectsFromArray:[object valueForKey:@"result"]];
                int nextPage = self.page.intValue + 1;
                self.page = [NSNumber numberWithInt:nextPage];
                
                //NSLog(@"数组中的元素个数为%lu",[object count]);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView.mj_footer endRefreshing];
                    [self.tableView reloadData];
                }];
                NSLog(@"上拉数据获取成功");
            }else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView.mj_footer endRefreshing];
                    //[self.tableView reloadData];
                }];
                [SVProgressHUD showErrorWithStatus:@"数据获取失败，请重新刷新"];
                [SVProgressHUD dismissWithDelay:2.0];
            }
        }else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView.mj_footer endRefreshing];
                //[self.tableView reloadData];
            }];
            [SVProgressHUD showErrorWithStatus:@"数据获取失败，请重新刷新"];
            [SVProgressHUD dismissWithDelay:2.0];
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
        myCell.contentView.backgroundColor = UIColor.voidColor;
        return myCell;
    }else {
        commodityCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"homeCommodityCell"];
        if (!myCell) {
            myCell = [[commodityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCommodityCell"];
        }
        myCell.commodityInfo = self.commodityInfo;
        myCell.tableViewSection = indexPath.section - 2;
        myCell.contentView.backgroundColor = UIColor.voidColor;
        return myCell;
    }
}

//section之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}

- (IBAction)goToSearch:(id)sender {
    NSArray *hotSearch = @[@"iPhone",@"iPad",@"MacBook",@"AirPods"];
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSearch searchBarPlaceholder:@"搜索您想要的商品" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        commodityListTableViewController *toController = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityListTableView"];
        toController.searchText = searchText;
        [searchViewController.navigationController pushViewController:toController animated:YES];
    }];
    
    //searchViewController.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:true completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

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
