//
//  waitShipTableViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/24.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderStatusTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface waitShipTableViewController : UITableViewController

@property NSArray *orderInfo;

@end

NS_ASSUME_NONNULL_END
