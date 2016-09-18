//
//  URLConfigurableInterceptor.m
//  SimpleCommon
//
//  Created by wuyp on 16/5/24.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLConfigurableInterceptor.h"

@implementation URLConfigurableInterceptor

- (BOOL)isMatchURLWithInput:(URLInput *)input
{
    NSString *baseUrl = input.pattern.lowercaseString;
    if (baseUrl.length == 0) {
        return NO;
    }
    
    for (NSString *url in self.except) {
        if ([baseUrl compare:url options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return NO;
        }
    }
    for (NSString *pattern in self.exceptPrefixs) {
        if ([baseUrl hasPrefix:pattern]) {
            return NO;
        }
    }
    for (NSString *url in self.urls) {
        if ([baseUrl compare:url options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return YES;
        }
    }
    for (NSString *pattern in self.urlPrefixs) {
        if ([baseUrl hasPrefix:pattern]) {
            return YES;
        }
    }
    return NO;
}

@end
