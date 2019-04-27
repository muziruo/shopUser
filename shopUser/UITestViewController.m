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
    
    [self.goToAR addTarget:self action:@selector(showAR) forControlEvents:UIControlEventTouchUpInside
     ];
    // Do any additional setup after loading the view.
}



-(void)showAR {
    
}


@end
