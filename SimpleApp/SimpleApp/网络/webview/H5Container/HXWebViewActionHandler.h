//
//  HXWebViewActionHandler.h
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface HXWebViewActionHandler : NSObject

@property (nonatomic, weak) WKWebView *webview;
@property (nonatomic, weak) UIViewController *currPage;

- (void)excute;

@end
