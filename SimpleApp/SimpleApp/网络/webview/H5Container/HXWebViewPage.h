//
//  HXWebViewPage.h
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKWebViewJavascriptBridge;

#import "HXWebViewActionHandler.h"
#import "HXWebViewLoadInterceptor.h"

@interface HXWebViewPage : UIViewController

@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *bridge;

- (void)loadURL:(NSString *)url;

- (void)loadURL:(NSString *)url interceptorAction:(InterceptorAction)action;

@end
