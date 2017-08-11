//
//  HXWebViewLoadInterrupt.h
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>

@interface HXWebViewLoadInterceptor : NSObject

@property (nonatomic, weak) WKWebView *webview;

- (void)excuteWithNavigation:(WKNavigationAction *)action completionHandler:(void(^)(BOOL isAllow))completion;

@end
