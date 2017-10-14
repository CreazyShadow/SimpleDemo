//
//  TestWebviewViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/8/16.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestWebviewViewController.h"
#import "UIWebView+Clean.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

#import <Aspects.h>

extern NSString * const maxCount;

@interface TestWebviewViewController ()<UIWebViewDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) WKWebView *wkwebview;

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation TestWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.wkwebview loadRequest:self.request];
    [self.view addSubview:self.wkwebview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"---");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"---");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (NSDictionary *)paramsFromURL:(NSString *)url {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *arr = [url componentsSeparatedByString:@"?"];
    if (arr.count == 2) {
        arr = [arr[1] componentsSeparatedByString:@"&"];
        for (int i = 0; i < arr.count; i++) {
            NSArray *temp = [arr[i] componentsSeparatedByString:@"="];
            [dict setObject:temp[1] forKey:temp[0]];
        }
    }
    
    return [dict copy];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"---- START");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"----- finish");
    NSString *js = @"document.readyState";
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable state, NSError * _Nullable error) {
        if ([state isKindOfClass:[NSString class]] && [state isEqualToString:@"complete"]) {
            NSLog(@"------ load complete");
        }
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    [self listenWebviewLoadingState:webView];
    [webView evaluateJavaScript:@"document.body.innerHTML" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"----- document length:%@", data);
    }];
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"Native"]) {
        NSLog(@"---------%@--%@", message.body, _wkwebview.URL);
    }
}

#pragma mark - cookie

- (void)setupCookie {
    NSMutableDictionary *fromappDict = [NSMutableDictionary dictionary];
    [fromappDict setObject:@"fromapp" forKey:NSHTTPCookieName];
    [fromappDict setObject:@"ios" forKey:NSHTTPCookieValue];
    // kDomain是公司app网址
    [fromappDict setObject:@"" forKey:NSHTTPCookieDomain];
    [fromappDict setObject:@"" forKey:NSHTTPCookieOriginURL];
    [fromappDict setObject:@"/" forKey:NSHTTPCookiePath];
    [fromappDict setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:fromappDict];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [storage setCookie:cookie];
    
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.cookit=''"];
}

#pragma mark - events

- (void)selectHeaderAction:(NSInteger)index {
    switch (index) {
        case 0:
            [self.wkwebview reload];
            
            break;
            
        case 1:
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:63342/HtmlNote/Base/InteractionNative.html?_ijt=b0cj9nhpp63esnkk1ev2pnnod3"]];
            [self.wkwebview loadRequest:request];
        }
            break;
            
        case 2:
            
            break;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"---%@", change[NSKeyValueChangeNewKey]);
    }
}

#pragma mark - getter & setter 

-(UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webview.delegate = self;
        
        _webview.height = 400;
    }
    
    return _webview;
}

- (WKWebView *)wkwebview {
    if (!_wkwebview) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        [config.userContentController addScriptMessageHandler:self name:@"Native"];
        
        _wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500) configuration:config];
        _wkwebview.allowsBackForwardNavigationGestures = YES;
        _wkwebview.navigationDelegate = self;
        _bottomLabel.y = _wkwebview.height - _bottomLabel.height;
        
        [_wkwebview aspect_hookSelector:@selector(goBack) withOptions:AspectPositionAfter usingBlock: ^{
            NSLog(@"------go back");
        } error:nil];
        
        [_wkwebview aspect_hookSelector:@selector(reload) withOptions:AspectPositionAfter usingBlock:^ {
            NSLog(@"----- reload");
        }error:nil];
    }
    
    return _wkwebview;
}

- (NSURLRequest *)request {
    if (!_request) {
        NSURL *url = [NSURL URLWithString:@"http://localhost:63342/HtmlNote/Base/InteractionNative.html?_ijt=b0cj9nhpp63esnkk1ev2pnnod3"];
        _request = [NSURLRequest requestWithURL:url];
    }
    
    return _request;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _bottomLabel.backgroundColor = [UIColor redColor];
        _bottomLabel.text = @"QQQQQQQQQ";
    }
    
    return _bottomLabel;
}

#pragma mark - 监听WKwebview加载状态

- (void)listenWebviewLoadingState:(WKWebView *)webview {
    NSString *js =
    @"document.onreadystatechange = function () {"
    " var dic = {'name' : 'jack'};"
    "    window.webkit.messageHandlers['Native'].postMessage(dic);"
    "};";
    
    [webview evaluateJavaScript:js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"-------%@", data);
    }];
}

#pragma mark - wkwebview 边缘手势

- (void)gestureForWebView:(WKWebView *)webview {
    for (UIGestureRecognizer *ges in webview.gestureRecognizers) {
        if ([ges isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            UIScreenEdgePanGestureRecognizer *screenGes = (UIScreenEdgePanGestureRecognizer *)ges;
            [screenGes addTarget:self action:@selector(webviewScreenGes:)];
        }
    }
}

- (void)webviewScreenGes:(UIScreenEdgePanGestureRecognizer *)ges {
    CGPoint point = [ges translationInView:self.view];
    WKWebView *webview = (WKWebView *)ges.view;
    [self printSubViews:webview];
//    NSLog(@"%@", NSStringFromCGPoint([ges translationInView:self.view]));
}

- (void)printSubViews:(UIView *)view {
    for (UIView *item in view.subviews) {
        NSLog(@"%@", item);
        [self printSubViews:item];
    }
}

@end
