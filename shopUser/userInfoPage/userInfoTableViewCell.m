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


@interface orderStatusCell ()

@property NSArray *status;

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
    orderCell.statusTitle.text = self.statusTitle[indexPath.item];
    orderCell.statusImage.image = [UIImage imageNamed:@"imageReplace-s"];
    
    return orderCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.frame.size.width - 20)/5, 55);
}

//在此配置订单状态点击跳转事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了第%li个按钮",(long)indexPath.item);
    if (indexPath.item == 0) {
        UIStoryboard *mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        waitShipTableViewController *orderView = [mainStoryBroad instantiateViewControllerWithIdentifier:@"waitShipView"];
        [[self getController].navigationController pushViewController:orderView animated:true];
    }
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



@implementation listCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.functionImage = [[UIImageView alloc] init];
        self.functionImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.functionImage];
        UIEdgeInsets imagePadding = UIEdgeInsetsMake(10, 30, -10, -20);
        [self.functionImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imagePadding.top);
            make.left.equalTo(self.mas_left).with.offset(imagePadding.left);
            make.bottom.equalTo(self.mas_bottom).with.offset(imagePadding.bottom);
            make.width.mas_equalTo(50);
        }];
        
        self.functionTitle = [[UILabel alloc] init];
        self.functionTitle.font = UIFont.normalFont;
        [self addSubview:self.functionTitle];
        UIEdgeInsets titlePadding = UIEdgeInsetsMake(10, 50, -10, -30);
        [self.functionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(titlePadding.top);
            make.bottom.equalTo(self.mas_bottom).with.offset(titlePadding.bottom);
            make.right.equalTo(self.mas_right).with.offset(titlePadding.right);
            make.left.equalTo(self.functionImage.mas_right).with.offset(titlePadding.left);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
