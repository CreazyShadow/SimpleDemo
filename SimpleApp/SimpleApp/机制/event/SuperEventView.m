//
//  SuperEventView.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/4.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "SuperEventView.h"

@implementation SuperEventView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *temp = [super hitTest:point withEvent:event];
    NSLog(@"super view hit test!%@",temp);
    return temp;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL flag = [super pointInside:point withEvent:event];
    NSLog(@"super view point inside!%d", flag);
    return flag;
}

@end
