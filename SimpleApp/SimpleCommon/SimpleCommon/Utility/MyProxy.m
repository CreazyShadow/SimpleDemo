//
//  MyProxy.m
//  SimpleCommon
//
//  Created by wuyp on 16/10/21.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "MyProxy.h"

@implementation MyProxy
{
    id _object;
}


+ (id)proxyForObject:(id)obj {
    MyProxy *proxy = [MyProxy alloc];
    proxy->_object = obj;
    return proxy;
}

#pragma mark - override

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_object methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([_object respondsToSelector:invocation.selector]) {
        NSLog(@"MyProxy before call selector: %@", NSStringFromSelector(invocation.selector));
        [invocation invokeWithTarget:_object];
        NSLog(@"MyProxy after call selector: %@", NSStringFromSelector(invocation.selector));
    }
}

@end
