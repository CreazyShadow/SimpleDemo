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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:63342/JSNote/HtmlBase/test.html"]];
    
    [self.webview loadRequest:request];
//    [self.webview sizeToFit];
//    [self.webview loadHTMLString:url baseURL:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDictionary *dic = @{@"YYTISRSA_KEY":@"Zc2dduYM4lxeB5GtzWvUqut5+1ickaYT9hUX4oKxh34AiaAmWoFyR/svGUV57BCgFVdFht1e0bAJfDZfwGz+w89ajvb1251PoWupAhYhWAfcqqsUswNNnQ7CSCm3oVl9YYF3MC7dSlFIVlZlEHZ/2n0nW4KPALkKQb+ATFnazdc=",
                          @"a":@"fVmwqp2zVmQFWNA2JGXdOSzg41DraDuXFMgHV1wN7g/8eb9j8vRbreqlvXmObHSsK9ouRP/BTmIDWweDkc7tcUL1EKEHKfrrjWH0yBNa5WhcVj6DyCELQByE2/U4vf8Nhv8jRiJElTePag0SkcoC3N0D1bARpz6SLIE9xWGIs0g=",
                          @"pageNo":@"OZexXFkSHDehRxdTjrP2V3uzkpi/iLFpeo6IceBnymag9Zyg+bU5ISgAFNjQVw5MDzcb0qT5wimxoyB//CzuTlEm1BvzjiZNrlRSQg2kSZOojbBdtSw0DzbTT3JwXGPatsMLaa/wLyVIK9m+LPuy7K9ZIu0jB8c6iwkmm4qVLdw=",
                          @"regionId":@"laJpHoPkAX9F2K+KPyqGI3IgN9jrRNo19VczuDm4c4Th8reMnu7Ws2S7y2cy0JlpxgGmHxXBr3eFXloWxf7NBTHU1eqG/SkacaNIIbTd6mp7puTq2mSmptnm6m0/N1ZNu8ZO9IbLLT5lKEfiA3ElNXh6ArNZ/RaQGI3mTiplonk="};
    dic = @{@"abc" : @"1321热热我发的范德萨范德萨"};
    NSString *str = [NSString stringWithFormat:@"log('%@')", [self dictionaryToJson:dic]];
   str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [self.webview stringByEvaluatingJavaScriptFromString:str];
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
