//
//  userInfoTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "userInfoTableViewCell.h"

@implementation userInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation orderStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
        self.orderCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:viewLayout];
        self.orderCollectionView.backgroundColor = UIColor.clearColor;
        self.orderCollectionView.delegate = self;
        self.orderCollectionView.dataSource = self;
        
        [self.orderCollectionView registerClass:[orderStatusCollectionViewCell class] forCellWithReuseIdentifier:@"orderStatusCell"];
        [self addSubview:self.orderCollectionView];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(5, 10, 5, 10);
        UIView *superView = self;
        [self.orderCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView).with.insets(padding);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    orderStatusCollectionViewCell *orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderStatusCell" forIndexPath:indexPath];
    
//    在此配置数据
    orderCell.statusTitle.text = @"状态";
    orderCell.statusImage.image = [UIImage imageNamed:@"imageReplace-s"];
    
    return orderCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.frame.size.width - 20)/5, 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了第%li个按钮",(long)indexPath.item);
}

@end
