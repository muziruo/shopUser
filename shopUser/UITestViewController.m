//
//  UITestViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "UITestViewController.h"

@interface UITestViewController ()

@end

@implementation UITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleText.font = UIFont.titleFont;
    _titleTextLight.font = UIFont.titleFontLight;
    _normalText.font = UIFont.normalFont;
    _normlTextLight.font = UIFont.normalFontLight;
    _descriptionText.font = UIFont.descriptionFont;
    _descriptionTextLight.font = UIFont.descriptionFontLight;
    _normalButton.backgroundColor = UIColor.buttonColor;
    _stressButton.backgroundColor = UIColor.stressColor;
    
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.barTintColor = UIColor.themeMainColor;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
