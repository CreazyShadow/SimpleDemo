//
//  NativeHandle.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/21.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "NativeHandle.h"

@implementation NativeHandle

- (void)login {
    NSLog(@"native login");
}

- (void)bindcard {
    NSLog(@"native bindcard");
}

- (void)cache {
    NSLog(@"native cache");
}

- (void)cacheName:(NSString *)name pwd:(NSString *)pwd {
    NSLog(@"native cache name:%@ pwd:%@", name, pwd);
}

@end
