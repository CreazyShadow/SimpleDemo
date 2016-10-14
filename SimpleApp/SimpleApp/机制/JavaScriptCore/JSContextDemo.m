//
//  JSContextDemo.m
//  SimpleApp
//
//  Created by wuyp on 16/9/8.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "JSContextDemo.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation JSContextDemo

#pragma mark - base introduce

- (void)simple {
    JSContext *context = [[JSContext alloc] init];
    JSValue *value = [context evaluateScript:@"1 + 2"];
    int iValue = [value toInt32];
    NSLog(@"JSValue: %@, oc: %d", value, iValue);
}

@end
