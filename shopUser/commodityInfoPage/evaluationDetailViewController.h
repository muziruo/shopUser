//
//  evaluationDetailViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/26.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseInfoTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface evaluationDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property NSArray *evaluationInfo;
@property NSString *commodityId;
@property NSNumber *page;

@property (weak, nonatomic) IBOutlet UITableView *evaluationTableView;


@end

NS_ASSUME_NONNULL_END
