//
//  homeTableViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "homePageTableViewCell.h"
#import "UIColor+themeUIColor.h"
#import "PYSearch.h"
#import "infoViewController.h"
#import "commodityListTableViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MJRefresh.h"
#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *searchInput;

-(void)getHomeCommodity;

@end

NS_ASSUME_NONNULL_END
