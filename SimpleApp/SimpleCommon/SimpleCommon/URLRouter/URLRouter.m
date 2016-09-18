//
//  URLRouter.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLRouter.h"
#import "URLOpenOptions.h"
#import "URLManager.h"
#import "NSError+URLRouter.h"
#import "URLLog.h"
#import "URLResult.h"

@implementation URLRouter

+ (void)loadConfiguration {
    [URLManager sharedInstance];
}

+ (BOOL)canOpenURL:(NSString *)URL {
    if (![URL isKindOfClass:[NSString class]] || [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return NO;
    }
    
    if ([URL.lowercaseString hasPrefix:@"patoa://pingan.com/test"]) {
        return NO;
    }
    
    return [[URLManager sharedInstance] canOpenURL:URL];
}

+ (void)openURL:(NSString *)URL {
    [self openURL:URL options:nil completion:nil];
}

+ (void)openURL:(NSString *)url options:(URLOpenOptions *)options completion:(void (^)(URLResult *))completion {
    if (![self canOpenURL:url]) {
        return;
    }
    
    [[URLManager sharedInstance] openURL:url options:options completion:completion];
}

@end
