//
//  GlobalInstance.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/28.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "GlobalInstance.h"

@implementation GlobalInstance

+ (instancetype)shareInstance {
    static GlobalInstance *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalInstance alloc] init];
    });
    
    return instance;
}

@end
