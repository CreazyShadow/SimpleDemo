//
//  Runtime_Super_Protected.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Runtime_Super_Protected.h"

#import <objc/runtime.h>
#import <objc/message.h>

#define ProtectedClass NSClassFromString(@"Runtime_Super_Inner_Class")

static NSString * const method = @"method_1";

@implementation Runtime_Super_Protected

+ (void)load {
    Method original = class_getInstanceMethod(ProtectedClass, NSSelectorFromString(method));
    Method new = class_getInstanceMethod(self, @selector(pro_method_1));
    method_exchangeImplementations(original, new);
}

- (BOOL)pro_method_1 {
    
    if ([[self valueForKey:@"name"] isEqualToString:@"jack"]) {
        return YES;
    }
    
    Method method = class_getInstanceMethod([Runtime_Super_Protected class], @selector(pro_method_1));
    IMP imp = method_getImplementation(method);
    return ((BOOL(*)(id))imp)(self);
}

- (void)imp:(IMP)ip {
    
}

@end
