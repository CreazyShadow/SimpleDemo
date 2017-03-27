//
//  UIScreenViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/17.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "UIScreenViewController.h"

@interface UIScreenViewController ()

@end

@implementation UIScreenViewController

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
    UIView *view = [UIScreen mainScreen].focusedView;
    
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
