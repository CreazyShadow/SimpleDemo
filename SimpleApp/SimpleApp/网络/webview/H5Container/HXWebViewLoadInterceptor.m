//
//  HXWebViewLoadInterrupt.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewLoadInterceptor.h"

#import "HXWebViewLoadInterceptorOpenNew.h"

#import "HXWebViewPage.h"

@implementation HXWebViewLoadInterceptor

//https://10.112.90.129?flag=300&hx_scheme=abc&title=jack

- (void)excuteWithNavigation:(WKNavigationAction *)action completionHandler:(void (^)(BOOL))completion {
    NSString *url = action.request.URL.absoluteString;
    BOOL flag = YES;
    
    if ([url containsString:@"flag"]) {
        HXWebViewPage *page = [[HXWebViewPage alloc] init];
        HXWebViewLoadInterceptor *interceptor = [[HXWebViewLoadInterceptorOpenNew alloc] init];
        [page loadURL:url interceptor:interceptor];
    } else if ([url containsString:@"hx_scheme"]) {
        //...
        flag = NO;
    } else if (0) { //需要解析URL
        
    }
    
    if (completion) {
        completion(flag);
    }
}

@end
