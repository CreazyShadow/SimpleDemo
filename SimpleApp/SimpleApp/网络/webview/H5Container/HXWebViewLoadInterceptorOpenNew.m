//
//  HXWebViewLoadInterceptorOpenNew.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/8.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewLoadInterceptorOpenNew.h"

@implementation HXWebViewLoadInterceptorOpenNew

- (void)excuteWithNavigation:(WKNavigationAction *)action completionHandler:(void (^)(BOOL))completion {
    NSString *url = action.request.URL.absoluteString;
    if ([url isEqualToString:@"flag"]) {
        completion(YES);
        return;
    }
    
    [super excuteWithNavigation:action completionHandler:completion];

}

@end
