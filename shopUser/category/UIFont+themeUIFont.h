//
//  UIFont+themeUIFont.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (themeUIFont)

+ (UIFont *)descriptionFont;
+ (UIFont *)descriptionFontLight;
+ (UIFont *)titleFont;
+ (UIFont *)titleFontLight;
+ (UIFont *)normalFont;
+ (UIFont *)normalFontLight;
+ (UIFont *)numberFont;

@end

NS_ASSUME_NONNULL_END
