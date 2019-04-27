//
//  UITestViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import <QuickLook/QuickLook.h>
#import <AVOSCloud/AVOSCloud.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *normalText;
@property (weak, nonatomic) IBOutlet UILabel *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLight;
@property (weak, nonatomic) IBOutlet UILabel *normlTextLight;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextLight;

@property (weak, nonatomic) IBOutlet UIButton *normalButton;
@property (weak, nonatomic) IBOutlet UIButton *stressButton;

@property (weak, nonatomic) IBOutlet UIButton *goToAR;


@end

NS_ASSUME_NONNULL_END
