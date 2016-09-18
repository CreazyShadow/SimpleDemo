//
//  UITextField+EventTextField.m
//  SimpleApp
//
//  Created by wuyp on 16/8/26.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "EventTextField.h"

@implementation EventTextField

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin = CGPointMake(100, 0);
    return rect;
}

@end
