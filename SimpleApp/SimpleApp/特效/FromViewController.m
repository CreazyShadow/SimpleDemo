//
//  FromViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "FromViewController.h"

#import "ToViewController.h"

@interface FromViewController ()

@end

@implementation FromViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
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
    [self.navigationController pushViewController:[ToViewController new] animated:YES];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
