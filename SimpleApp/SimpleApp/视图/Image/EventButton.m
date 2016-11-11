//
//  UIButton+EventButton.m
//  SimpleApp
//
//  Created by wuyp on 16/8/26.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "EventButton.h"

@implementation EventButton

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//
//    NSLog(@"----button hit");
//    return [super pointInside:point withEvent:event];
//}
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    NSLog(@"----button point inside");
//    return [super hitTest:point withEvent:event];
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"------init");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"-------init with frame");
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"-------coder");
    return [super initWithCoder:aDecoder];
}

@end
