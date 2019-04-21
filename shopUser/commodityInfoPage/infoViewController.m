//
//  infoViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/19.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@property NSArray *evaluationInfo;

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
    
    if ([self.info valueForKey:@"objectId"] != nil) {
        [self getCommodityEvaluation];
    }
    // Do any additional setup after loading the view.
}

-(void)getCommodityEvaluation {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:[self.info valueForKey:@"objectId"] forKey:@"commodityID"];
    [AVCloud callFunctionInBackground:@"getCommodityEvaluation" withParameters:parameters block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.evaluationInfo = object;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.infoTableView reloadData];
            }];
        }
    }];
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
            return 2;
            break;
        case 2:
            if ([self.evaluationInfo count] == 0) {
                return 2;
            }
            return 1 + [self.evaluationInfo count];
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
                if ([self.info valueForKey:@"price"] == nil) {
                    cell.infoLabel.text = @"价格";
                }else {
                    NSString *price = @"¥";
                    NSString *priceNum = [NSNumberFormatter localizedStringFromNumber:[self.info valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
                    price = [price stringByAppendingString:priceNum];
                    cell.infoLabel.text = price;
                }
                cell.infoLabel.font = UIFont.titleFont;
                cell.infoLabel.textColor = UIColor.redColor;
                cell.userInteractionEnabled = false;
                break;
            case 1:
                if ([self.info valueForKey:@"name"] == nil) {
                    cell.infoLabel.text = @"商品名称";
                }else{
                    cell.infoLabel.text = [self.info valueForKey:@"name"];
                }
                cell.infoLabel.font = UIFont.normalFont;
                cell.infoLabel.numberOfLines = 0;
                cell.userInteractionEnabled = false;
                break;
            case 2:
                if ([self.info valueForKey:@"description"] == nil) {
                    cell.infoLabel.text = @"商品描述";
                }else {
                    cell.infoLabel.text = [self.info valueForKey:@"description"];
                }
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
            cell.infoLabel.text = @"型号";
            cell.infoLabel.font = UIFont.descriptionFontLight;
            cell.userInteractionEnabled = false;
            return cell;
        }
        if (indexPath.row == 1) {
            baseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseInfoTableViewCell"];
            if (!cell) {
                cell = [[baseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"baseInfoTableViewCell"];
            }
            cell.infoLabel.text = @"请选择参数";
            cell.infoLabel.tag = 777;
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
            if ([self.evaluationInfo count] == 0) {
                baseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseInfoTableViewCell"];
                if (!cell) {
                    cell = [[baseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"baseInfoTableViewCell"];
                }
                cell.infoLabel.text = @"暂无评论";
                cell.infoLabel.font = UIFont.descriptionFont;
                cell.userInteractionEnabled = false;
                return cell;
            }
            commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentTableViewCell"];
            if (!cell) {
                cell = [[commentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentTableViewCell"];
            }
            cell.userAvator.image = [UIImage imageNamed:@"imageReplace-s"];
            cell.userNickName.text = @"用户昵称";
            if ([self.evaluationInfo valueForKey:@"info"] == nil) {
                cell.commentInfo.text = @"评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息";
            }else {
                cell.commentInfo.text = [self.evaluationInfo[indexPath.row - 1] valueForKey:@"info"];
            }
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
    NSArray *dateSource = @[@"型号1",@"型号2",@"型号3",@"型号4",@"型号5"];
    [BRStringPickerView showStringPickerWithTitle:@"选择参数" dataSource:dateSource defaultSelValue:@"请选择参数" isAutoSelect:YES themeColor:UIColor.grayColor resultBlock:^(id selectValue) {
        UILabel *canshu = [tableView viewWithTag:777];
        canshu.text = selectValue;
    } cancelBlock:^{
        NSLog(@"取消了选择");
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
