//
//  homePageTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "homePageTableViewCell.h"


/**
 主页轮播图cell
 */
@implementation homePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//自定义cell需要在该方法里面进行配置
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        NSURL *image1 = [NSURL URLWithString:@"http://muziruo.com/image/laimeiyun/jpg/lmybiqi.JPG"];
        NSURL *image2 = [NSURL URLWithString:@"http://muziruo.com/image/laimeiyun/jpg/background0707.jpg"];
        NSArray *iamgeUrls = @[image1,image2];
        
        self.myView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 375, 200) delegate:self placeholderImage:[UIImage imageNamed:@"zhanweitu.png"]];
        self.myView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        
        self.myView.imageURLStringsGroup = iamgeUrls;
        [self addSubview:self.myView];
    }
    
    return self;
}

//请在此配置大小
- (void)layoutSubviews {
    [self.myView setFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    commodityListTableViewController *commodityInfoView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityInfoView"];
    [[self getController].navigationController pushViewController:commodityInfoView animated:true];
}

- (UIViewController *)getController {
    for (UIView *nextView =[self superview]; nextView; nextView = nextView.superview) {
        UIResponder *getResponder = [nextView nextResponder];
        if ([getResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)getResponder;
        }
    }
    return nil;
}

@end



/**
 主页分类cell
 */
@implementation homeCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

//此处为自定义tableviewcell的布局点，在此处加上cell中最上层的视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.homeCategory = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        self.homeCategory.backgroundColor = UIColor.whiteColor;
        self.homeCategory.delegate = self;
        self.homeCategory.dataSource = self;
        
        [self.homeCategory registerClass:[homeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCategoryCell"];
        [self addSubview: self.homeCategory];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(5, 5, 5, 5);
        UIView *superView = self;
        [self.homeCategory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView).with.insets(padding);
        }];
    }
    
    return self;
}

//请在此设置大小
- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

//设置collection中item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width/6, (collectionView.frame.size.height - 10) / 2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    homeCollectionViewCell *homeCategoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCategoryCell" forIndexPath:indexPath];
    
    homeCategoryCell.categoryImage.image = [UIImage imageNamed:@"imageReplace-s"];
    homeCategoryCell.categoryName.text = @"分类";
    
    return homeCategoryCell;
}

//点击跳转事件,跳转到商品列表页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了第%li个按钮",(long)indexPath.item);
    
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    commodityListTableViewController *commodityList = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityListTableView"];
    [[self getController].navigationController pushViewController:commodityList animated:true];
}

- (UIViewController *)getController {
    for (UIView *nextView =[self superview]; nextView; nextView = nextView.superview) {
        UIResponder *getResponder = [nextView nextResponder];
        if ([getResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)getResponder;
        }
    }
    return nil;
}

@end




/**
 主页商品cell
 */
@implementation commodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UICollectionViewFlowLayout *cellLayout = [[UICollectionViewFlowLayout alloc] init];
        cellLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.homeCommodity = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:cellLayout];
        self.homeCommodity.backgroundColor = UIColor.whiteColor;
        self.homeCommodity.delegate = self;
        self.homeCommodity.dataSource = self;
        
        [self.homeCommodity registerClass:[commodityCollectionViewCell class] forCellWithReuseIdentifier:@"homeCommodityCell"];
        [self addSubview:self.homeCommodity];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(5, 5, 5, 5);
        UIView *superView = self;
        [self.homeCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView).with.insets(padding);
        }];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.frame.size.width - 20) / 2, self.frame.size.height - 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    commodityCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCommodityCell" forIndexPath:indexPath];
    
//    请在此配置数据
    
    myCell.commodityName.text = [self.commodityInfo[indexPath.row] valueForKey:@"name"];
    myCell.commodityImage.image = [UIImage imageNamed:@"imageReplace"];
    myCell.price.text = @"¥9999";
    
    return myCell;
}

//点击事件，跳转到具体商品页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了第%li",(long)indexPath.item);
    
    UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    infoViewController *commodityInfoView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"commodityInfoView"];
    [[self getController].navigationController pushViewController:commodityInfoView animated:true];
}

- (UIViewController *)getController {
    for (UIView *nextView =[self superview]; nextView; nextView = nextView.superview) {
        UIResponder *getResponder = [nextView nextResponder];
        if ([getResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)getResponder;
        }
    }
    return nil;
}

@end
