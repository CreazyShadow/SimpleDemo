//
//  HXWebViewLoadInterrupt.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewLoadInterceptor.h"

#import "HXWebViewPage.h"

@interface HXWebViewLoadInterceptor()

@property (nonatomic, assign) InterceptorAction action;

@end

@implementation HXWebViewLoadInterceptor

//https://10.112.90.129?flag=300&hx_scheme=abc&title=jack

#pragma mark - init

+ (instancetype)interceptorWithAction:(InterceptorAction)action {
    HXWebViewLoadInterceptor *instance = [[HXWebViewLoadInterceptor alloc] init];
    instance.action = action;
    return instance;
}

#pragma mark - 特殊处理

#pragma mark - 普通处理

- (void)excuteWithNavigation:(WKNavigationAction *)action completionHandler:(completionHander)completion {
    NSString *url = action.request.URL.absoluteString;
    BOOL flag = NO;
    
    if ([url containsString:@"new"]) {
        HXWebViewPage *page = [[HXWebViewPage alloc] init];
        [page loadURL:@"" interceptorAction:InterceptorActionCommon];
    }
    else if ([url containsString:@"hx_scheme"]) {
        
    }
    else if ([url containsString:@"3"]) {
        
    }
    
    completion(flag);
}

- (void)excuteCommon:(NSString *)url completionHandler:(completionHander)completion {
    BOOL flag = NO;
    if ([url containsString:@"hx_scheme"]) {
        //....
        NSLog(@"break");
    } else if ([url containsString:@"..."]) {
        flag = YES;
    }
    
    completion(flag);
}

- (void)excuteOpenNew:(NSString *)url completionHandler:(completionHander)completion {
    BOOL flag = NO;
    if ([url containsString:@"flag"]) {
        HXWebViewPage *page = [[HXWebViewPage alloc] init];
        //open new
    }
    
    completion(flag);
}

@end
