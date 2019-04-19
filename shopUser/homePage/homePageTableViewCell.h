//
//  homePageTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "homeCollectionView.h"
#import "homeCollectionViewCell.h"
#import "Masonry.h"
#import "commodityListTableViewController.h"
#import "commodityCollectionViewCell.h"
#import "infoViewController.h"

NS_ASSUME_NONNULL_BEGIN

//轮播图cell
@interface homePageTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic) SDCycleScrollView *myView;

-(UIViewController *)getController;

@end

//主页分类cell
@interface homeCategoryCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *homeCategory;

-(UIViewController *)getController;

@end

//商品cell
@interface commodityCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *homeCommodity;

-(UIViewController *)getController;

@end


NS_ASSUME_NONNULL_END
