//
//  HXWebViewLoadInterrupt.h
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>

@interface HXWebViewLoadInterrupt : NSObject

@property (nonatomic, assign) BOOL allow;

- (instancetype)initWithWebView:(WKWebView *)webview;

- (void)excute;

@end
