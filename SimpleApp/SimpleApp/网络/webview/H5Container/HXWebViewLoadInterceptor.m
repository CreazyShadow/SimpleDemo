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

- (void)excuteWithCompletionHandler:(void (^)(BOOL))completion {
    NSString *url = self.navigatorAction.request.URL.absoluteString;
    BOOL flag = YES;
    
    if ([url containsString:@"flag"]) {
        HXWebViewPage *page = [[HXWebViewPage alloc] init];
        HXWebViewLoadInterceptor *interceptor = [[HXWebViewLoadInterceptorOpenNew alloc] init];
        [page loadURL:url interceptor:interceptor];
    } else if ([url containsString:@"hx_scheme"]) {
        //...
        flag = NO;
    }
    
    if (completion) {
        completion(flag);
    }
}

@end
