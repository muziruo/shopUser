//
//  UIColor+themeUIColor.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/16.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "UIColor+themeUIColor.h"

@implementation UIColor (themeUIColor)

//以下的颜色均描述为中国色

//按钮颜色，星蓝
+ (UIColor *)buttonColor{
    return [UIColor colorWithRed:147.0/255.0 green:181.0/255.0 blue:207.0/255.0 alpha:1.0];
}

//强调颜色，海棠红
+ (UIColor *)stressColor {
    return [UIColor colorWithRed:240.0/255.0 green:55.0/255.0 blue:82.0/255.0 alpha:1.0];
}

//主题颜色，宝石蓝 #2486b9
+ (UIColor *)themeMainColor {
    return [UIColor colorWithRed:36.0/255.0 green:134.0/255.0 blue:185.0/255.0 alpha:1.0];
}

//空隙颜色
+ (UIColor *)voidColor {
    return [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
}

@end
