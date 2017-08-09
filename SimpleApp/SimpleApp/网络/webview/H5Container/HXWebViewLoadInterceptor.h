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

@property (nonatomic, strong) WKNavigationAction *navigatorAction;

- (void)excuteWithCompletionHandler:(void(^)(BOOL isAllow))completion;

@end
