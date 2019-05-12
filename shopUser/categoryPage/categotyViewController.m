//
//  categotyViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "categotyViewController.h"

@interface categotyViewController ()

@property NSArray *levelOne;

@end

@implementation categotyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _levelOne = @[@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类",@"分类"];
    
//    设置导航栏标题字体和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont navTitleFont], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _levelOne.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    levelOneTableViewCell *levelOneCell = [tableView dequeueReusableCellWithIdentifier:@"levelOneTitle" forIndexPath:indexPath];
    
    levelOneCell.categoryTitle.text = _levelOne[indexPath.row];
    
    return levelOneCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _levelOne.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    levelTwoCollectionViewCell *levelTwoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"levelTwoCell" forIndexPath:indexPath];
    
    levelTwoCell.categoryImage.image = [UIImage imageNamed:@"imageReplace-s"];
    levelTwoCell.categoryImage.clipsToBounds = YES;
    levelTwoCell.categoryImage.contentMode = UIViewContentModeScaleAspectFill;
    
    levelTwoCell.levelTwoTitle.text = _levelOne[indexPath.row];
    levelTwoCell.levelTwoTitle.font = UIFont.normalFontLight;
    
    return levelTwoCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    commodityListTableViewController *commodityListView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityListTableView"];
    [self.navigationController pushViewController:commodityListView animated:true];
}

@end
