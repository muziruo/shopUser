//
//  loginViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建标签
    self.myTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 50)];
    self.myTitleView.delegate = self;
    self.myTitleView.titles =@[@"登录",@"注册"];
    self.myTitleView.titleColorGradientEnabled = YES;
    self.myTitleView.titleSelectedColor = UIColor.themeMainColor;
    self.myTitleView.titleColor = UIColor.grayColor;
    [self.view addSubview:self.myTitleView];
    
    //标签处于何处的指示器
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = UIColor.themeMainColor;
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    self.myTitleView.indicators = @[lineView];
    
    self.cancel = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 90, 20, 70, 50)];
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancel setTitleColor:UIColor.themeMainColor forState:UIControlStateNormal];
    [self.cancel.titleLabel setFont:UIFont.normalFont];
    [self.cancel addTarget:self action:@selector(cancelBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancel];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    [self.listContainerView setFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 120)];
    [self.view addSubview:self.listContainerView];
    self.myTitleView.contentScrollView = self.listContainerView.scrollView;
    
//    _pageControl.backgroundColor = UIColor.clearColor;
//    _pageControl.tintColor = UIColor.clearColor;
//    
//    NSDictionary *attribute = @{: UIFont.titleFont};
//    NSDictionary *colorAttribute = @{UITextAttributeTextColor: UIColor.themeMainColor};
//    [_pageControl setTitleTextAttributes:attribute forState:UIControlStateNormal];
//    [_pageControl setTitleTextAttributes:colorAttribute forState:UIControlStateSelected];
//    [_pageControl setTitleTextAttributes:@{UITextAttributeTextColor: UIColor.grayColor} forState:UIControlStateNormal];
//    [_pageControl addTarget:self action:@selector(selectedViewAnimation) forControlEvents:UIControlEventValueChanged];
//    
//    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(_pageControl.layer.frame.origin.x, _pageControl.layer.frame.origin.y + 40, _pageControl.layer.frame.size.width / 2, 5)];
//    _selectedView.backgroundColor = UIColor.themeMainColor;
//    [self.view addSubview:_selectedView];
//    
//    JVFloatLabeledTextView *ceshi = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(40, 160, 200, 50)];
//    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(ceshi.layer.frame.origin.x, ceshi.frame.origin.y + 50, 200, 2)];
//    inputView.backgroundColor = UIColor.themeMainColor;
//    ceshi.placeholder = @"ceshi";
//    ceshi.floatingLabelTextColor = UIColor.themeMainColor;
//    
//    [self.view addSubview:ceshi];
//    [self.view addSubview:inputView];
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.myTitleView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return [[listViewController alloc] init];
            break;
        case 1:
            return [[registerViewController alloc] init];
        default:
            return nil;
            break;
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:_myTitleView.selectedIndex];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)cancelBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
