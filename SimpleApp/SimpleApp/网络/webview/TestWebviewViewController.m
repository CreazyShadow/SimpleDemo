//
//  TestWebviewViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/8/16.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestWebviewViewController.h"
#import "UIWebView+Clean.h"

@interface TestWebviewViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation TestWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.webview];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:63342/FirstProject/basehtml.html?_ijt=fl27hleo8fnk5jh4254cbgu6ml"]];
    
    [self.webview loadRequest:request];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
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
//    NSString *url = request.URL.absoluteString;
//    if ([url hasPrefix:@"http://"]) {
//        if ([url containsString:@"native"]) {
//            NSDictionary *params = [self paramsFromURL:url];
//            NSString *msg = [params objectForKey:@"msg"];
//            NSLog(@"%@", msg);
//            return NO;
//        }
//        
//        return YES;
//    }
    
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

#pragma mark - getter & setter 

-(UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webview.delegate = self;
        
        _webview.height = 400;
    }
    
    return _webview;
}

@end
