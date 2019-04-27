//
//  selectLocalViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/27.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>

NS_ASSUME_NONNULL_BEGIN

@protocol selectLocalViewControllerDelegate <NSObject>

-(void)changeLocal:(long)selectedRow;

@end

@interface selectLocalViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *localListTableView;
@property NSArray *localList;

@property(nonatomic, weak) id<selectLocalViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
