//
//  HXWebViewLoadInterrupt.h
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger, InterceptorAction) {
    InterceptorActionDefault,
    InterceptorActionSpecial,
    InterceptorActionCommon,
};

@class HXWebViewPage;

typedef void(^completionHander)(BOOL isAllow);

@interface HXWebViewLoadInterceptor : NSObject

@property (nonatomic, weak) HXWebViewPage *webviewPage;

+ (instancetype)interceptorWithAction:(InterceptorAction)action;

- (void)excuteWithNavigation:(WKNavigationAction *)action completionHandler:(completionHander)completion;

@end
