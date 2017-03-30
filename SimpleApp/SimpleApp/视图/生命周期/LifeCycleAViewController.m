//
//  LifeCycleAViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "LifeCycleAViewController.h"

#import "VIewLifeCycleViewController.h"

@interface LifeCycleAViewController ()

@end

@implementation LifeCycleAViewController

#pragma mark - life cycle

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 30)];
//    [super loadView];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.navigationController) {
        self.view.frame = CGRectMake(0, 64 + 30, kScreenWidth, kScreenHeight - 94);
    } else {
        self.view.frame = CGRectMake(0, 30, kScreenWidth, kScreenHeight - 94);
    }
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    VIewLifeCycleViewController *b = [[VIewLifeCycleViewController alloc] init];
    b.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.navigationController pushViewController:b animated:YES];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
