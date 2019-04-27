//
//  ARViewController.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/27.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARViewController : UIViewController<QLPreviewControllerDelegate, QLPreviewControllerDataSource, NSURLSessionDownloadDelegate>

@property NSString *filePath;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

NS_ASSUME_NONNULL_END
