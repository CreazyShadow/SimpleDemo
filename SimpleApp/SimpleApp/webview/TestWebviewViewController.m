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
    
    [self.view addSubview:self.webview];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/js_ocdemo.html"]];
    
    [self.webview loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    if ([url hasPrefix:@"http://"]) {
        if ([url containsString:@"native"]) {
            NSDictionary *params = [self paramsFromURL:url];
            NSString *msg = [params objectForKey:@"msg"];
            NSLog(@"%@", msg);
            return NO;
        }
        
        return YES;
    }
    
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

#pragma mark - getter & setter 

-(UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webview.delegate = self;
    }
    
    return _webview;
}

@end
