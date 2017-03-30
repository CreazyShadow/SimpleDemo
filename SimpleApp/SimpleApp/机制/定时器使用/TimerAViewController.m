//
//  TimerAViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TimerAViewController.h"

#import "TimerBViewController.h"

#import "RayTimer.h"

@interface TimerAViewController ()

@end

@implementation TimerAViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Timer";
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
    TimerBViewController *b = [[TimerBViewController alloc] init];
    [self.navigationController pushViewController:b animated:YES];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
