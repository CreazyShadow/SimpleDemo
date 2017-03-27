//
//  SendMessageClass.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "SendMessageClass.h"

@implementation SendMessageClass


- (void)say {
    NSLog(@"%@ %s", NSStringFromClass(self.class), __func__);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}

#pragma mark - 第一步 动态添加方法

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"eat"]) {
        //此处可以动态添加方法
        return YES;
    }
    
    return NO;
}

#pragma mark - 第二步 快速转发：只能单独转发

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

#pragma mark - 第三步 慢速转发：转发给多个对象

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    
//}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

@end
