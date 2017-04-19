//
//  ConstrantViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/17.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ConstrantViewController.h"

@interface ConstrantViewController ()

@end

@implementation ConstrantViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor redColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - init subviews

#pragma mark - event

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
