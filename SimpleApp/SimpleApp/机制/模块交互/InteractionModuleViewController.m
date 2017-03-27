//
//  InteractionModuleViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "InteractionModuleViewController.h"

#import <TestViewController_1.h>

@interface InteractionModuleViewController ()

@end

@implementation InteractionModuleViewController

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
    TestViewController_1 *vc = [[TestViewController_1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
