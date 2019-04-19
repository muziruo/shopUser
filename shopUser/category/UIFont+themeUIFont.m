//
//  UIFont+themeUIFont.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "UIFont+themeUIFont.h"

@implementation UIFont (themeUIFont)

//描述性字体
+ (UIFont *)descriptionFont {
    return [UIFont fontWithName:@"Avenir" size:13];
}

//描述性字体细体
+ (UIFont *)descriptionFontLight {
    return [UIFont fontWithName:@"Avenir-light" size:13];
}

//标题字体
+ (UIFont *)titleFont {
    return [UIFont fontWithName:@"Avenir-medium" size:20];
}

//标题字体细体
+ (UIFont *)titleFontLight {
    return [UIFont fontWithName:@"Avenir" size:20];
}

+ (UIFont *)normalFont {
    return [UIFont fontWithName:@"Avenir" size:15];
}

+ (UIFont *)normalFontLight {
    return [UIFont fontWithName:@"Avenir-light" size:15];
}

+ (UIFont *)numberFont {
    return [UIFont fontWithName:@"Avenir" size:14];
}

@end
