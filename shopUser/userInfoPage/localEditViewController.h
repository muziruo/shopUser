//
//  localEditViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "receiptLocalTableViewCell.h"
#import <BRPickerView/BRPickerView.h>

NS_ASSUME_NONNULL_BEGIN

@protocol localEditViewControllerDelegate <NSObject>

-(void)addedLocal;

@end


@interface localEditViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *localEditTableView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

//是创建还是修改，1是修改，0是添加
@property int editOrCreate;
//需要编辑的地址信息
@property NSDictionary *editLocalInfo;

@property BOOL isFrist;


//刷新代理
@property (nonatomic, weak) id<localEditViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
