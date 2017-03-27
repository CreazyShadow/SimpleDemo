//
//  AFNViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/22.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "AFNViewController.h"

#import <AFNetworking.h>

@interface AFNViewController ()

@end

@implementation AFNViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - network

#pragma mark - 上传文件

- (void)uploadFile {
    NSDictionary *params = @{@"file" : @"img",
                             @"name" : @"jack",
                             @"pwd"  : @"123456"};
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:@"https://www.baidu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - private

#pragma mark - getter & setter

@end
