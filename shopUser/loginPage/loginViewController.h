//
//  loginViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+themeUIColor.h"
#import "UIFont+themeUIFont.h"
#import "JVFloatLabeledTextView.h"
#import "JXCategoryView.h"
#import "listViewController.h"
#import "registerViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface loginViewController : UIViewController<JXCategoryListContainerViewDelegate,JXCategoryListContentViewDelegate, JXCategoryViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *pageControl;

@property UIView *selectedView;
@property JXCategoryTitleView *myTitleView;
@property JXCategoryListContainerView *listContainerView;
@property UIButton *cancel;

-(void)selectedViewAnimation;

@end

NS_ASSUME_NONNULL_END
