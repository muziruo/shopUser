//
//  homePageTableViewCell.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/10.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "homePageTableViewCell.h"

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
        
        SDCycleScrollView *myView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 375, 200) delegate:self placeholderImage:[UIImage imageNamed:@"zhanweitu.png"]];
        myView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        myView.imageURLStringsGroup = iamgeUrls;
        [self addSubview:myView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation homeCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
