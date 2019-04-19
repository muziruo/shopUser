//
//  infoTableViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/18.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "infoTableViewController.h"

@interface infoTableViewController ()

@end

@implementation infoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSURL *image1 = [NSURL URLWithString:@"http://muziruo.com/image/laimeiyun/jpg/lmybiqi.JPG"];
    NSURL *image2 = [NSURL URLWithString:@"http://muziruo.com/image/laimeiyun/jpg/background0707.jpg"];
    NSArray *iamgeUrls = @[image1,image2];
    self.commodityImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400) delegate:self placeholderImage:[UIImage imageNamed:@"imageReplace"]];
    self.commodityImage.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.commodityImage.imageURLStringsGroup = iamgeUrls;
    [self.view addSubview:self.commodityImage];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择参数");
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.row) {
//        case 0:
//            return 40;
//            break;
//        case 1:
//            return 30;
//            break;
//        case 2:
//            return 30;
//            break;
//        default:
//            return 30;
//            break;
//    }
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
