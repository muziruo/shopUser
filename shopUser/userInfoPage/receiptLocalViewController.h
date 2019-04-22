//
//  receiptLocalViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "receiptLocalTableViewCell.h"
#import "localEditViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface receiptLocalViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *receiptLocalTableView;
@property (weak, nonatomic) IBOutlet UIButton *addLoacl;

@end

NS_ASSUME_NONNULL_END
