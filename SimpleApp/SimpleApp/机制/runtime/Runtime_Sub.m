//
//  Runtime_Sub.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Runtime_Sub.h"

#import <objc/runtime.h>

@interface Runtime_Sub()

- (void)sub_private_method;

@end

@implementation Runtime_Sub

#pragma mark - public 

- (void)sub_public_method {
    PrintMethodDescription
}

#pragma mark - sub

- (void)sub_private_method {
    PrintMethodDescription
}

#pragma mark - runtime message

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

@end
