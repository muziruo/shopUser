//
//  SUSelectButton.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/28.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "SUSelectButton.h"

@implementation SUSelectButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//通过重写该方法来实现扩大点击范围
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthLarge = 26;
    CGFloat heightLarge = 26;
    bounds = CGRectInset(bounds, -widthLarge/2, -heightLarge/2);
    return CGRectContainsPoint(bounds, point);
}

@end
