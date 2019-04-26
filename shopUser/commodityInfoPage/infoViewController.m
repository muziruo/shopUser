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
@property UIStoryboard *mainStoryBroad;

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainStoryBroad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.infoTableView.rowHeight = UITableViewAutomaticDimension;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    
    NSURL *image1 = [NSURL URLWithString:@"http://lc-ahj3its7.cn-n1.lcfile.com/84bb660e43f9ef2da95e/background0707-s.jpg"];
    NSURL *image2 = [NSURL URLWithString:@"http://lc-ahj3its7.cn-n1.lcfile.com/812d8b0a6a1032184925/IMG_3945-s.JPG"];
    NSArray *iamgeUrls = @[image1,image2];
    self.commodityImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400) delegate:self placeholderImage:[UIImage imageNamed:@"imageReplace"]];
    self.commodityImage.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.commodityImage.imageURLStringsGroup = iamgeUrls;
    [self.imageArea addSubview:self.commodityImage];
    
    self.buyButton.backgroundColor = UIColor.buttonColor;
    self.addCart.backgroundColor = UIColor.stressColor;
    
    [self.buyButton addTarget:self action:@selector(buyCommodity) forControlEvents:UIControlEventTouchUpInside];
    [self.addCart addTarget:self action:@selector(addCartFunction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.info valueForKey:@"objectId"] != nil) {
        [self getCommodityEvaluation];
        [self getImage];
        [self getStock];
    }
    // Do any additional setup after loading the view.
}


//添加购物车
-(void)addCartFunction {
    
    if (self.selectedModel == nil) {
        NSLog(@"请先选择型号");
    }else {
        NSDictionary *params = @{@"number":@1,@"userId":@"5cbc8182c8959c00751357ca",@"commodityId":[self.info valueForKey:@"objectId"],@"commodityStockId":self.selectedModel};
        [AVCloud callFunctionInBackground:@"addShoppingCar" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"添加购物车成功");
            }
        }];
    }
}


//获取评论信息
-(void)getCommodityEvaluation {
    NSDictionary *parameters = @{@"commodityId":[self.info valueForKey:@"objectId"],@"type":@1,@"page":@0};
    [AVCloud callFunctionInBackground:@"getCommodityEvaluation" withParameters:parameters block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([object valueForKey:@"success"]) {
                self.evaluationInfo = [object valueForKey:@"resultInfo"];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.infoTableView reloadData];
                }];
            }
        }
    }];
}



//获取库存信息
-(void)getStock {
    NSDictionary *params = [NSDictionary dictionaryWithObject:[self.info valueForKey:@"objectId"] forKey:@"commodityId"];
    [AVCloud callFunctionInBackground:@"getStock" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.stock = object;
        }
    }];
}



//获取q图片信息
-(void)getImage {
    NSDictionary *params = [NSDictionary dictionaryWithObject:[self.info valueForKey:@"objectId"] forKey:@"commodityId"];
    [AVCloud callFunctionInBackground:@"getCommodityImage" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            NSMutableArray *imageUrl = [[NSMutableArray alloc] init];
            for (int i = 0; i < [object count]; i++) {
                [imageUrl addObject:[object[i] valueForKey:@"imageUrl"]];
            }
            self.commodityImage.imageURLStringsGroup = imageUrl;
        }
    }];
}



//获取店铺信息
-(void)getShopInfo {
    
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
            return 2 + [self.evaluationInfo count];
            break;
        default:
            return 0;
            break;
    }
}



//配置cell
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
                cell.infoLabel.tag = 666;
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
            cell.infoLabel.text = @"选择型号";
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
//
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
//
            if (indexPath.row == 3) {
                buttonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
                
                if (!cell) {
                    cell = [[buttonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"buttonCell"];
                }
                
                return cell;
            }
//
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
            //cell.userInteractionEnabled = false;
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
    
    if (indexPath.section == 1) {
        
        if ([self.stock count] == 0) {
            UILabel *canshu = [tableView viewWithTag:777];
            canshu.text = @"暂无可选型号";
            canshu.userInteractionEnabled = false;
        }else {
            NSMutableArray *dateSource = [[NSMutableArray alloc] init];
            for (int i = 0; i < [self.stock count]; i++) {
                [dateSource addObject:[self.stock[i] valueForKey:@"commodityModel"]];
            }
            [BRStringPickerView showStringPickerWithTitle:@"选择参数" dataSource:dateSource defaultSelValue:@"请选择参数" isAutoSelect:YES themeColor:UIColor.themeMainColor resultBlock:^(id selectValue) {
                
                UILabel *canshu = [tableView viewWithTag:777];
                canshu.text = selectValue;
                
                NSInteger index = [dateSource indexOfObject:selectValue];
                self.selectedModel = [self.stock[index] valueForKey:@"objectId"];
                
                ////            改变价格
                //            UILabel *modelPrice = [tableView viewWithTag:666];
                //            NSString *price = @"¥";
                //            NSString *priceNum = [NSNumberFormatter localizedStringFromNumber:[self.stock valueForKey:@"price"] numberStyle:NSNumberFormatterNoStyle];
                //            price = [price stringByAppendingString:priceNum];
                
                
            } cancelBlock:^{
                NSLog(@"取消了选择");
            }];
        }
        
    }else if (indexPath.section == 2){
        
        evaluationDetailViewController *evaluateView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"evaluationDetailView"];
        evaluateView.commodityId = [self.info valueForKey:@"objectId"];
        [self.navigationController pushViewController:evaluateView animated:true];
        
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)buyCommodity{
    orderViewController *orderView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"orderView"];
    [self.navigationController pushViewController:orderView animated:true];
}

@end
