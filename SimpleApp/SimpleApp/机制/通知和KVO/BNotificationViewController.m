//
//  BNotificationViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "BNotificationViewController.h"

@interface BNotificationViewController ()

@end

@implementation BNotificationViewController

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
    NSNotification *nc = [[NSNotification alloc] initWithName:@"notification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:nc];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
