//
//  ProxyViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/27.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ProxyViewController.h"
#import <MyProxy.h>

@interface ProxyViewController ()

@end

@implementation ProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testProxy];
    
}

#pragma mark - test proxy

- (void)testProxy {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    NSURL *baidu = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURL *url = [MyProxy proxyForObject:baidu];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_semaphore_signal(sem);
        NSLog(@"request successed.");
    }];
    
    [task resume];
}


@end
