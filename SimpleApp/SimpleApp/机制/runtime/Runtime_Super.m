//
//  Runtime_Super.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Runtime_Super.h"

@interface Runtime_Super()

- (void)private_method;

@end

@implementation Runtime_Super

#pragma mark - message send

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - public

- (void)inherited_method {
    PrintMethodDescription
}

#pragma mark - private

- (void)private_method {
    PrintMethodDescription
}

@end


#pragma mark - Inner class

@interface Runtime_Super_Inner_Class : Runtime_Super

@end

@implementation Runtime_Super_Inner_Class

- (BOOL)method_1 {
    PrintMethodDescription
    return NO;
}

@end
