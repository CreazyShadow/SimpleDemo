//
//  ObjectProtectedManager.m
//  SimpleCommon
//
//  Created by BYKJ on 2017/8/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ObjectProtectedManager.h"

#import <objc/runtime.h>

@implementation ObjectProtectedManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static ObjectProtectedManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ObjectProtectedManager alloc] init];
    });
    
    return instance;
}

@end
