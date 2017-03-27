//
//  SessionCustomProtocolConfiguration.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "SessionCustomProtocolConfiguration.h"

#import "SessionCustomeProtocol.h"
#import "CustomURLProtocol.h"
#import "NSURLProtocol+WebKitSupport.h"

#import <objc/message.h>
#import <objc/runtime.h>

@implementation SessionCustomProtocolConfiguration

+ (instancetype)shareManager {
    static SessionCustomProtocolConfiguration *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SessionCustomProtocolConfiguration alloc] init];
    });
    
    return instance;
}

- (NSArray *)protocolClasses {
    return @[[SessionCustomeProtocol class]];
}

- (void)swizzleSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub {
    
    Method originalMethod = class_getInstanceMethod(original, selector);
    Method stubMethod = class_getInstanceMethod(stub, selector);
    if (!originalMethod || !stubMethod) {
        [NSException raise:NSInternalInconsistencyException format:@"Couldn't load NSURLSession hook."];
    }
    method_exchangeImplementations(originalMethod, stubMethod);
}

#pragma mark - public

- (void)openSessionProtocol {
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
    
    [NSURLProtocol registerClass:[SessionCustomeProtocol class]];
    
    [NSURLProtocol wk_registerScheme:@"http"];
    [NSURLProtocol wk_registerScheme:@"https"];
}

- (void)openHttpProtocol {
    [NSURLProtocol registerClass:[CustomURLProtocol class]];
    
    [NSURLProtocol wk_registerScheme:@"http"];
    [NSURLProtocol wk_registerScheme:@"https"];
}

@end
