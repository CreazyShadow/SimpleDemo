//
//  ToViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ToViewController.h"

@interface ToViewController ()

@end

@implementation ToViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
