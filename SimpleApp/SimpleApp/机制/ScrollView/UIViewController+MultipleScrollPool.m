//
//  UIViewController+MultipleScrollPool.m
//  SimpleApp
//
//  Created by wuyp on 2017/12/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "UIViewController+MultipleScrollPool.h"

#import <objc/runtime.h>

static void *kScrollPoolKey = &kScrollPoolKey;

@interface UIViewController ()

@property (nonatomic, strong) NSMutableArray<UIScrollView *> *scrollPool;

@end

@implementation UIViewController (MultipleScrollPool)

#pragma mark - cache pool

- (void)cacheScrollView:(UIScrollView *)scroll {
    if (![self.scrollPool containsObject:scroll]) {
        [self.scrollPool addObject:scroll];
    }
}

- (NSArray<UIScrollView *> *)allScroll {
    return [self.scrollPool copy];
}

- (void)cleanScrollPool {
    [self.scrollPool removeAllObjects];
}

#pragma mark - propertys

- (NSMutableArray<UIScrollView *> *)scrollPool {
    NSMutableArray *pool = objc_getAssociatedObject(self, kScrollPoolKey);
    if ([pool isKindOfClass:[NSMutableArray class]]) {
        return pool;
    }
    
    return [[NSMutableArray alloc] init];
}

- (void)setScrollPool:(NSMutableArray<UIScrollView *> *)scrollPool {
    objc_setAssociatedObject(self, kScrollPoolKey, scrollPool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
