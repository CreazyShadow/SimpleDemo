//
//  UIButton+EventButton.m
//  SimpleApp
//
//  Created by wuyp on 16/8/26.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "EventButton.h"

@implementation EventButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {

    NSLog(@"----button hit");
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"----button point inside");
    return [super hitTest:point withEvent:event];
}

@end
