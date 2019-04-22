//
//  localEditViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "receiptLocalTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface localEditViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *localEditTableView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


//需要编辑的地址信息
@property NSDictionary *editLocalInfo;

@end

NS_ASSUME_NONNULL_END
