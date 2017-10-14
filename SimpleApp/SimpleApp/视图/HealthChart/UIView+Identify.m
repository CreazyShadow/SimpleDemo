//
//  UIView+Identify.m
//  SimpleApp
//
//  Created by wuyp on 2017/6/8.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "UIView+Identify.h"

#import <objc/runtime.h>

static void *key = &key;

@implementation UIView (Identify)

- (NSString *)identify {
    return objc_getAssociatedObject(self, key);
}

- (void)setIdentify:(NSString *)identify {
    objc_setAssociatedObject(self, key, identify, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
