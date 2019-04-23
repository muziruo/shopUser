//
//  commodityListTableViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+themeUIFont.h"
#import "commodityListTableViewCell.h"
#import "PYSearch.h"
#import "infoViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <AVOSCloud/AVOSCloud.h>

NS_ASSUME_NONNULL_BEGIN

@interface commodityListTableViewController : UITableViewController


@property NSString *searchText;

@end

NS_ASSUME_NONNULL_END
