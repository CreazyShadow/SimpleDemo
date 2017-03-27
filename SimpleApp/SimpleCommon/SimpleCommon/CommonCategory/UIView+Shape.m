//
//  UIView+Shape.m
//  SimpleCommon
//
//  Created by wuyp on 2016/12/22.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "UIView+Shape.h"

#import <objc/runtime.h>

static NSString * const kIsCircleKey = @"CircleKey";

@implementation UIView (Shape)

@dynamic circle;

- (BOOL)isCircle {
    return [objc_getAssociatedObject(self, &kIsCircleKey) boolValue];
}

- (void)setCircle:(BOOL)isCircle {
    objc_setAssociatedObject(self, &kIsCircleKey, [NSNumber numberWithBool:isCircle], OBJC_ASSOCIATION_ASSIGN);
}

@end
