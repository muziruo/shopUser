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

NS_ASSUME_NONNULL_BEGIN

@interface homeTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *searchInput;

@end

NS_ASSUME_NONNULL_END
