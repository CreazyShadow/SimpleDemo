//
//  TestUIWebViewViewController.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/7.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "TestUIWebViewViewController.h"

@interface TestUIWebViewViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation TestUIWebViewViewController

#pragma mark - life cycle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    [self.view addSubview:self.webview];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:63342/StudyNote/StudyBase/%E7%99%BB%E5%BD%95%E9%A1%B5%E9%9D%A2/login.html?_ijt=mo0knevsvjhgtimmujca6m0jvb"]];
    [_webview loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark - subviews

#pragma mark - event responder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - network

#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self loadJSFile];
    NSLog(@"--- start load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"--- load finished");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

#pragma mark - public

#pragma mark - private

- (void)loadJSFile {
    
    NSString *loadJS = @""
    "var head = document.getElementsByTagName('head').item(0);"
    "var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.src = 'http://127.0.0.1:8080/login.js';"
    "document.documentElement.appendChild('script');";
    NSString *origin = @"<script type='text/javascript' src='http://127.0.0.1:8080/login.js'></script>";
    NSString *js1 = [NSString stringWithFormat:@"javascript:%@", origin];
    [self.webview stringByEvaluatingJavaScriptFromString:js1];
}

#pragma mark - getter & setter

- (UIWebView *)webview {
    if(!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
        _webview.backgroundColor = [UIColor orangeColor];
        _webview.delegate = self;
        _webview.layer.borderColor = [UIColor orangeColor].CGColor;
        _webview.layer.borderWidth = 1.f;
    }
    
    return _webview;
}

@end
