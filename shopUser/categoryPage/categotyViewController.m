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
    
    levelTwoCell.categoryImage.image = [UIImage imageNamed:@"zhanweitu.png"];
    levelTwoCell.levelTwoTitle.text = _levelOne[indexPath.row];
    
    return levelTwoCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
