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
#import <MJRefresh.h>

extern NSString * const maxCount;

@interface TestWebviewViewController ()< WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) WKWebView *wkwebview;

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation TestWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.wkwebview];
    self.wkwebview.frame = CGRectMake(0, 300, 375, 500);
    
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

#pragma mark - events

- (void)selectHeaderAction:(NSInteger)index {
    switch (index) {
        case 0:
            [self.wkwebview reload];
            
            break;
            
        case 1:
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:63342/StudyNote/test/FixLayoutRefresh.html?_ijt=i6nml82a1m1lsuffiqao6gttb3"]];
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
        
        __weak typeof(self) weakSelf = self;
        _wkwebview.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.wkwebview reload];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_wkwebview.scrollView.mj_header endRefreshing];
            });
        }];
    }
    
    return _wkwebview;
}

- (NSURLRequest *)request {
    if (!_request) {
        NSURL *url = [NSURL URLWithString:@"http://localhost:63342/StudyNote/test/CacheStorage.html?_ijt=nke2uqt65n9s14bq65f4gr7aba"];
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

#pragma mark - wkwebview清除缓存

- (void)clearWkWebViewCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record in records)
                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                             }
                         }];
    } else {
        
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    }
}

@end
