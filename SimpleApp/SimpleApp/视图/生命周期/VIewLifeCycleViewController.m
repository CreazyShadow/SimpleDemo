//
//  VIewLifeCycleViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "VIewLifeCycleViewController.h"

@interface VIewLifeCycleViewController ()

@end

@implementation VIewLifeCycleViewController

#pragma mark - life cycle

- (void)loadView {
    [super loadView];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewWillLayoutSubviews {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLayoutSubviews {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - init subviews

#pragma mark - event

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
