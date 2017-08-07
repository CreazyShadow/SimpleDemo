//
//  HXWebViewPage.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewPage.h"
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>

@interface HXWebViewPage ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;

@property (nonatomic, strong) NSArray<HXWebViewActionHandler *> *handlers;
@property (nonatomic, strong) HXWebViewLoadInterrupt *interrupt;

@end

@implementation HXWebViewPage

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_webView.title.length == 0) {
        [_webView reload];
    }
}

#pragma mark - init

- (void)openUrl:(NSString *)url actionHandler:(NSArray *)handler interrupt:(HXWebViewLoadInterrupt *)interrupt {
    if (url.length == 0) {
        return;
    }
    
    _handlers = handler && [handler isKindOfClass:[NSArray class]] ? [handler copy] : nil;
    _interrupt = interrupt;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

#pragma mark - webview

- (WKWebView *)webview {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [_webView setBackgroundColor:[UIColor clearColor]];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        
        [WKWebViewJavascriptBridge enableLogging];
        
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
        [_bridge setWebViewDelegate:self];
        
        //监控加载进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        
        //监控title变化
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [_webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    return _webView;
}

#pragma mark - WKUIDelegate

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //处理webview打开方式
    if (_interrupt) {
        [_interrupt excute];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - KVO

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
}


@end
