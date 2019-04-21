//
//  userInfoTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "userInfoTableViewController.h"

@interface userInfoTableViewController ()

@property NSUserDefaults *userSetting;

@end

@implementation userInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userSetting = [NSUserDefaults standardUserDefaults];
    
    _avatorimage.image = [UIImage imageNamed:@"imageReplace-s"];
    _userNickName.font = UIFont.normalFont;
    
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//在此跳转到登录页面
-(void)userLogin {
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loginViewController *loginView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"loginView"];
    [self presentViewController:loginView animated:true completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    if (![self.userSetting valueForKey:@"isLogin"]) {
        [self.userNickName setTitle:@"登录/注册" forState:UIControlStateNormal];
        [self.userNickName addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [self.userNickName setTitle:@"昵称" forState:UIControlStateNormal];
        self.userNickName.userInteractionEnabled = false;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 85;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        orderStatusCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"orderStatusCell"];
        if (!myCell) {
            myCell = [[orderStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderStatusCell"];
        }
        return myCell;
    }
    return nil;
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
