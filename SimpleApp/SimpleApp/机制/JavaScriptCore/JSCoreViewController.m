//
//  JSCoreViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/21.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "JSCoreViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import "NativeHandle.h"

NSString * const kJSFileName = @"jscontextdemo.js";

@interface JSCoreViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation JSCoreViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
    self.jsContext = [[JSContext alloc] init];
    
    [self relevanceJSContext:self.jsContext jsString:[self loadJsFile]];
}

#pragma mark - init subviews

- (void)initWebView {
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 300)];
    webview.delegate = self;
    webview.layer.borderColor = [UIColor redColor].CGColor;
    webview.layer.borderWidth = 1.0f;
    [self.view addSubview:webview];
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sendFunctionToJsByExport];
}

#pragma mark - jscontext

#pragma mark - network

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - private

- (NSString *)loadJsFile {
    NSString *file = [[NSBundle mainBundle] pathForResource:[kJSFileName stringByDeletingPathExtension] ofType:kJSFileName.pathExtension];
    return [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
}

- (void)relevanceJSContext:(JSContext *)context jsString:(NSString *)js {
    [context evaluateScript:js];
}

- (void)login {
    NSLog(@"---native log in");
}

#pragma mark - jscontext

- (void)sum {
    JSValue *function = self.jsContext[@"add"];
    JSValue *sum = [function callWithArguments:@[@1, @2]];
    NSLog(@"%d", [sum toInt32]);
}

#pragma mark - 通过block暴露方法

- (void)sendFunctionToJSByBlock {
    __weak typeof(self) weakSelf = self;
    self.jsContext[@"login"] = ^{
        [weakSelf login];
        return @"user login success";
    };
}

#pragma mark - JSExport

- (void)sendFunctionToJsByExport {
    self.jsContext[@"Native"] = [NativeHandle new];
    
    JSValue *loginFunction = self.jsContext[@"login"];
    [loginFunction callWithArguments:nil];
    
    JSValue *cacheFunction = self.jsContext[@"cache"];
//    [cacheFunction callWithArguments:@[@"jack", @"1234"]];
    [cacheFunction callWithArguments:nil];
}

#pragma mark - JSManagerValue:对JsValue进行包装的弱引用

#pragma mark - getter & setter

@end
