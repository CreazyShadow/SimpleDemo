//
//  OcInvokeSwiftViewController.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/22.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "OcInvokeSwiftViewController.h"

#import "SimpleApp-Swift.h"

@interface OcInvokeSwiftViewController ()

@end

@implementation OcInvokeSwiftViewController

#pragma mark - life cycle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UserModel *model = [[UserModel alloc] init];
    NSDictionary *dict = @{@"name" : @"jack",
                           @"age" : [NSNumber numberWithInt:12],
                           @"score" : [NSNumber numberWithFloat:98.5]
                           };
    [model setModelWithDict:dict];
    
}

#pragma mark - network

#pragma mark - tableview delegate & datasource

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

@end
