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
    
    NSURL *image1 = [NSURL URLWithString:@"http://lc-ahj3its7.cn-n1.lcfile.com/0f24c8f619a064832190/backgroun1.png"];
    NSURL *image2 = [NSURL URLWithString:@"http://lc-ahj3its7.cn-n1.lcfile.com/0b998d3751403a657873/background2.png"];
    NSArray *iamgeUrls = @[image1,image2];
    self.commodityImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400) delegate:self placeholderImage:[UIImage imageNamed:@"imageReplace"]];
    self.commodityImage.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.commodityImage.imageURLStringsGroup = iamgeUrls;
    [self.imageArea addSubview:self.commodityImage];
    
    self.buyButton.backgroundColor = UIColor.buttonColor;
    self.addCart.backgroundColor = UIColor.stressColor;
    
    [self.buyButton addTarget:self action:@selector(buyCommodity) forControlEvents:UIControlEventTouchUpInside];
    [self.addCart addTarget:self action:@selector(addCartFunction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collect addTarget:self action:@selector(collectCommodity) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.detailInfo == nil) {
        NSLog(@"无数据");
    }
    
    if ([self.info valueForKey:@"objectId"] != nil) {
        [self getCommodityDetail];
        [self getCommodityEvaluation];
        [self getImage];
        [self getStock];
    }
    
    
    
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"页面出现就获取收藏信息");
    if ([AVUser currentUser] != nil) {
        [self isCollected];
    }
}


-(void)collectCommodity {
    
    if ([AVUser currentUser] == nil) {
        //[SVProgressHUD showErrorWithStatus:@"请先登录"];
        [self needLogin];
        return;
    }
    
    if ([self.collect.imageView.image isEqual:[UIImage imageNamed:@"collect"]]) {
        //[SVProgressHUD showSuccessWithStatus:@"添加收藏"];
        [self.collect setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateNormal];
        
        NSDictionary *params = @{@"userId":[AVUser currentUser].objectId, @"commodityId":[self.info valueForKey:@"objectId"]};
        [AVCloud callFunctionInBackground:@"setCollectionCommodity" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([[object valueForKey:@"success"] boolValue]) {
                    self.collectInfo = [object valueForKey:@"result"];
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    [SVProgressHUD dismissWithDelay:0.8];
                }else {
                    
                }
            }
        }];
        
    }else if ([self.collect.imageView.image isEqual:[UIImage imageNamed:@"collected"]]){
        //[SVProgressHUD showSuccessWithStatus:@"取消收藏"];
        [self.collect setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        
        NSDictionary *params = @{@"collectionId":[self.collectInfo valueForKey:@"objectId"]};
        [AVCloud callFunctionInBackground:@"deleteCollection" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([[object valueForKey:@"isSuccess"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
                    [SVProgressHUD dismissWithDelay:0.8];
                }
            }
        }];
    }
}


-(void)isCollected {
    
    if ([AVUser currentUser] == nil) {
        return;
    }
    
    NSDictionary *params = @{@"userId":[AVUser currentUser].objectId, @"commodityId":[self.info valueForKey:@"objectId"]};
    
    [AVCloud callFunctionInBackground:@"isCollection" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"后台传回数据格式为%@",[[object valueForKey:@"isCollection"] className]);
            
            
            if ([[object valueForKey:@"isCollection"] boolValue]) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    self.collectInfo = [object valueForKey:@"collectInfo"];
                    //self.collect.imageView.image = [UIImage imageNamed:@"collected"];
                    [self.collect setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateNormal];
                }];
            }else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    //self.collect.imageView.image = [UIImage imageNamed:@"collect"];
                    [self.collect setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                }];
            }
        }
    }];
}


//获取商品详细信息
-(void)getCommodityDetail {
    NSString *commodityId = [self.info valueForKey:@"objectId"];
    NSDictionary *params = @{@"commodityId":commodityId};
    [AVCloud callFunctionInBackground:@"getCommodityInfo" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            if ([object valueForKey:@"success"]) {
                self.detailInfo = [object valueForKey:@"result"][0];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.infoTableView reloadData];
                }];
            }
        }
    }];
}


//添加购物车
-(void)addCartFunction {
    
    if ([AVUser currentUser] == nil) {
        //[SVProgressHUD showErrorWithStatus:@"请先登录"];
        [self needLogin];
        return;
    }
    
    if (self.selectedModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"未选择型号"];
    }else {
        NSDictionary *params = @{
                                 @"number":@1,
                                 @"userId":[AVUser currentUser].objectId,
                                 @"commodityId":[self.info valueForKey:@"objectId"],
                                 @"commodityStockId":[self.selectedModel valueForKey:@"objectId"]
                                 };
        [AVCloud callFunctionInBackground:@"addShoppingCar" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
            if (error == nil) {
                if ([object valueForKey:@"success"]) {
                    [SVProgressHUD showSuccessWithStatus:@"添加购物车成功"];
                    [SVProgressHUD dismissWithDelay:0.5];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"添加出错"];
                    [SVProgressHUD dismissWithDelay:0.5];
                }
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
    return 4;
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
        case 3:
            return 1;
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
                if ([self.detailInfo valueForKey:@"price"] == nil) {
                    cell.infoLabel.text = @"价格";
                }else {
                    NSString *price = @"¥";
                    NSLog(@"出错前价格数据%@",[self.detailInfo valueForKey:@"price"]);
                    
                    NSNumber *currentNum = [self.info valueForKey:@"price"];
                    NSLog(@"正确显示的MNSnumber为:%@",currentNum);
                    NSNumber *priceNumber  = [self.detailInfo valueForKey:@"price"];
                    NSLog(@"出错前获取的价格NSNumber为：%@",priceNumber);
                    NSString *priceNum = [NSNumberFormatter localizedStringFromNumber:priceNumber numberStyle:NSNumberFormatterNoStyle];
                    //NSLog(@"获取的商品具体信息是:",self.detailInfo);
                    NSLog(@"出错前价格数据%@",priceNum);
                    price = [price stringByAppendingString:priceNum];
                    cell.infoLabel.text = price;
                }
                cell.infoLabel.font = UIFont.titleFont;
                cell.infoLabel.textColor = UIColor.redColor;
                cell.infoLabel.tag = 666;
                cell.userInteractionEnabled = false;
                break;
            case 1:
                if ([self.detailInfo valueForKey:@"name"] == nil) {
                    cell.infoLabel.text = @"商品名称";
                }else{
                    cell.infoLabel.text = [self.detailInfo valueForKey:@"name"];
                }
                cell.infoLabel.font = UIFont.normalFont;
                cell.infoLabel.numberOfLines = 0;
                cell.userInteractionEnabled = false;
                break;
            case 2:
                if ([self.detailInfo valueForKey:@"description"] == nil) {
                    cell.infoLabel.text = @"商品描述";
                }else {
                    cell.infoLabel.text = [self.detailInfo valueForKey:@"description"];
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
            if (indexPath.row == 1 + [self.evaluationInfo count]) {
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
            
            NSURL *imageUrl = [NSURL URLWithString:[[self.evaluationInfo[indexPath.row - 1] valueForKey:@"userId"] valueForKey:@"avatar"]];
            
            [cell.userAvator sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"imageReplace-s"]];
            
            cell.userNickName.text = [[self.evaluationInfo[indexPath.row - 1] valueForKey:@"userId"] valueForKey:@"nickName"];
            
            if ([self.evaluationInfo valueForKey:@"info"] == nil) {
                cell.commentInfo.text = @"评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息评论信息";
            }else {
                cell.commentInfo.text = [self.evaluationInfo[indexPath.row - 1] valueForKey:@"info"];
            }
            //cell.userInteractionEnabled = false;
            return cell;
        }
    }else if (indexPath.section == 3){
        baseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seeAR"];
        if (!cell) {
            cell = [[baseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seeAR"];
        }
        cell.infoLabel.text = @"实体查看";
        cell.infoLabel.font = UIFont.normalFontLight;
        cell.infoLabel.textColor = UIColor.themeMainColor;
        
        return cell;
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
                self.selectedModel = self.stock[index];
                NSLog(@"选择的型号为:%@",self.selectedModel);
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
        
    }else if (indexPath.section == 3){
        
        ARViewController *ARView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"ARView"];
        [self.navigationController pushViewController:ARView animated:true];
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)buyCommodity{
    
    if ([AVUser currentUser] == nil) {
        //[SVProgressHUD showErrorWithStatus:@"请先登录"];
        [self needLogin];
        return;
    }
    
//    首先检查是否选择了型号
    if (self.selectedModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"未选择型号"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    orderViewController *orderView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"orderView"];
    orderView.selectedStock = self.selectedModel;
    
    NSMutableArray *commodityList = [[NSMutableArray alloc] init];
    [commodityList addObject:self.detailInfo];
    NSLog(@"传递的商品数量为:%lu",(unsigned long)[commodityList count]);
    orderView.commodityList = commodityList;
    orderView.fromShoppingCar = false;
    
    [self.navigationController pushViewController:orderView animated:true];
}


-(void)needLogin {
    loginViewController *loginView = [self.mainStoryBroad instantiateViewControllerWithIdentifier:@"loginView"];
    [self presentViewController:loginView animated:true completion:nil];
}

@end
