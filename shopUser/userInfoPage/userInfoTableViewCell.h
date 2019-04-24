//
//  userInfoTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderStatusCollectionViewCell.h"
#import "Masonry.h"
#import "UIFont+themeUIFont.h"
#import "waitShipTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface userInfoTableViewCell : UITableViewCell


@end


@interface orderStatusCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property UICollectionView *orderCollectionView;
@property NSArray *statusTitle;
@property NSArray *statusImage;

@end


@interface listCell : UITableViewCell

@property UIImageView *functionImage;
@property UILabel *functionTitle;

@end

NS_ASSUME_NONNULL_END
