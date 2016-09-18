//
//  Dog.m
//  SimpleModel
//
//  Created by wuyp on 16/5/25.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>

static NSString * const kEatMethod = @"eat";
static NSString * const kSayMethod = @"say";

@implementation Dog

#pragma mark eat method has declare

void eat(id self, SEL cdm) {
    NSLog(@"%@ is eating", self);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    NSString *selName = NSStringFromSelector(sel);
    if ([selName isEqualToString:kEatMethod]) {
        class_addMethod(self, sel, (IMP)eat, "v@:");
        return YES;
    }
    
    if ([selName isEqualToString:kSayMethod]) {
        return NO;
    }
    
    return [super resolveClassMethod:sel];
}

#pragma mark - say method is not declare

//第二步：备选提供响应aSelector的对象，我们不备选，因此设置为nil，就会进入第三步
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

// 第三步：先返回方法选择器。如果返回nil，则表示无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:kSayMethod]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

//设置调用say方法的对象
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:nil];
}

@end
