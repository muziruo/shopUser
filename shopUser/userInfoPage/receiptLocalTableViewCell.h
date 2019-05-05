//
//  receiptLocalTableViewCell.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/22.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+themeUIFont.h"
#import "loginViewController.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface receiptLocalTableViewCell : UITableViewCell

@property UILabel *receiptName;
@property UILabel *receiptNumber;
@property UILabel *receiptLocal;
@property UILabel *isDefault;

@end



@interface localEditCell : UITableViewCell

@property UILabel *infoTitle;
@property UITextField *infoInput;

@end


@interface defaultCell : UITableViewCell

@property UILabel *defaultTitle;
@property UISwitch *defaultSwitch;

@end

NS_ASSUME_NONNULL_END
