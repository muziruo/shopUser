//
//  shoppingCarViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "shoppingCarTableViewCell.h"
#import "infoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface shoppingCarViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *shopCarTableView;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

NS_ASSUME_NONNULL_END
