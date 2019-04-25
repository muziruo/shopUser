//
//  orderDetailViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/25.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderDetailTableViewCell.h"
#import "receiptLocalTableViewCell.h"
#import "orderStatusTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface orderDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;


@end

NS_ASSUME_NONNULL_END
