//
//  HXWebViewLoadInterceptorOpenNew.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/8.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewLoadInterceptorOpenNew.h"

@implementation HXWebViewLoadInterceptorOpenNew

- (void)excuteWithCompletionHandler:(void (^)(BOOL))completion {
    if (completion) {
        completion(YES);
    }
}

@end
