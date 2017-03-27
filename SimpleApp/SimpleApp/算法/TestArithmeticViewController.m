//
//  TestArithmeticViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TestArithmeticViewController.h"

#import "ClassicsArithmetic.h"

@interface TestArithmeticViewController ()

@end

@implementation TestArithmeticViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"算法";
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
    NSInteger index = [ClassicsArithmetic selectedIndexWithTotalCount:100 range:1];
    NSLog(@"----select index:%ld", index);
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
