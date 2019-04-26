//
//  evaluateViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/26.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <Masonry/Masonry.h>
#import "GRStarsView.h"
#import <AVOSCloud/AVOSCloud.h>
#import <SVProgressHUD/SVProgressHUD.h>


NS_ASSUME_NONNULL_BEGIN

@interface evaluateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *scoreArea;
@property (weak, nonatomic) IBOutlet UITextView *inputInfo;


@property GRStarsView *stars;
@property NSNumber *score;

@end

NS_ASSUME_NONNULL_END
