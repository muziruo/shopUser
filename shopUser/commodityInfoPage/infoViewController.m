//
//  infoViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/19.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoTableView.rowHeight = UITableViewAutomaticDimension;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    
    NSURL *image1 = [NSURL URLWithString:@"http://muziruo.com/image/laimeiyun/jpg/lmybiqi.JPG"];
    NSURL *image2 = [NSURL URLWithString:@"http://muziruo.com/image/laimeiyun/jpg/background0707.jpg"];
    NSArray *iamgeUrls = @[image1,image2];
    self.commodityImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400) delegate:self placeholderImage:[UIImage imageNamed:@"imageReplace"]];
    self.commodityImage.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.commodityImage.imageURLStringsGroup = iamgeUrls;
    [self.imageArea addSubview:self.commodityImage];
    
    self.buyButton.backgroundColor = UIColor.buttonColor;
    self.addCart.backgroundColor = UIColor.stressColor;
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        baseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseInfoTableViewCell"];
        if (!cell) {
            cell = [[baseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"baseInfoTableViewCell"];
        }
        
        switch (indexPath.row) {
            case 0:
                cell.infoLabel.text = @"价格";
                cell.infoLabel.font = UIFont.titleFont;
                cell.infoLabel.textColor = UIColor.redColor;
                cell.userInteractionEnabled = false;
                break;
            case 1:
                cell.infoLabel.text = @"商品信息 商品信息 商品信息 商品信息 商品信息 商品信息 商品信息";
                cell.infoLabel.font = UIFont.normalFont;
                cell.infoLabel.numberOfLines = 0;
                cell.userInteractionEnabled = false;
                break;
            case 2:
                cell.infoLabel.text = @"商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述 商品描述";
                cell.infoLabel.font = UIFont.descriptionFontLight;
                cell.infoLabel.numberOfLines = 0;
                cell.userInteractionEnabled = false;
                break;
            default:
                break;
        }
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            baseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseInfoTableViewCell"];
            if (!cell) {
                cell = [[baseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"baseInfoTableViewCell"];
            }
            cell.infoLabel.text = @"请选择参数";
            cell.infoLabel.textColor = UIColor.themeMainColor;
            cell.infoLabel.font = UIFont.normalFont;
            return cell;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            baseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseInfoTableViewCell"];
            if (!cell) {
                cell = [[baseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"baseInfoTableViewCell"];
            }
            cell.infoLabel.text = @"评论";
            cell.infoLabel.font = UIFont.descriptionFontLight;
            cell.userInteractionEnabled = false;
            return cell;
        }else {
            commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentTableViewCell"];
            if (!cell) {
                cell = [[commentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentTableViewCell"];
            }
            cell.userAvator.image = [UIImage imageNamed:@"imageReplace-s"];
            cell.userNickName.text = @"用户昵称";
            cell.commentInfo.text = @"评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息";
            cell.userInteractionEnabled = false;
            return cell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择参数");
}

@end
