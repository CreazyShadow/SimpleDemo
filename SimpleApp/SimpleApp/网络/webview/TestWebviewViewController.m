//
//  TestWebviewViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/8/16.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestWebviewViewController.h"
#import "UIWebView+Clean.h"

#import <WebKit/WebKit.h>

@interface TestWebviewViewController ()<UIWebViewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) WKWebView *wkwebview;

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation TestWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    
    [self.wkwebview loadRequest:self.request];
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

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"----- wkwebview load finished.");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (webView.backForwardList) {
        
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
            [self.view addSubview:self.wkwebview];
            break;
            
        case 1:
        {
            id arr = @[@1, @2, @3];
            [arr addObject:@"123"];
        }
            break;
            
        case 2:
            
            break;
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
        _wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500) configuration:[WKWebViewConfiguration new]];
        _wkwebview.allowsBackForwardNavigationGestures = YES;
        _wkwebview.navigationDelegate = self;
        [_wkwebview addSubview:self.bottomLabel];
        _bottomLabel.y = _wkwebview.height - _bottomLabel.height;
        [self gestureForWebView:_wkwebview];
    }
    
    return _wkwebview;
}

- (NSURLRequest *)request {
    if (!_request) {
        NSURL *url = [NSURL URLWithString:@"https://h5-ztb-uat.shhxzq.com/h5/html/news/list.html?columnId=030008&deviceId=D53UkPveJGUqI56nlGUjpM&v=2.7.0&snsAccount=SNS20170510428902193139361348&deviceType=3&time=2017081809&token=&clientId=&hasActive=1"];
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
