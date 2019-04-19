//
//  infoTableViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "baseInfoTableViewCell.h"
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"

NS_ASSUME_NONNULL_BEGIN

@interface infoTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *imageArea;

@property SDCycleScrollView *commodityImage;


@end

NS_ASSUME_NONNULL_END
