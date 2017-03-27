//
//  ChildEventView.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/4.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ChildEventView.h"

@implementation ChildEventView


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *temp = [super hitTest:point withEvent:event];
    NSLog(@"child view hit test!%@",temp);
    return temp;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL flag = [super pointInside:point withEvent:event];
    NSLog(@"child view point inside!%d", flag);
    return flag;
}

@end
