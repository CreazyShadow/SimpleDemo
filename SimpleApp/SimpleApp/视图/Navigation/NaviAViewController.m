//
//  NaviAViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "NaviAViewController.h"

#import "NaviBViewController.h"

@interface NaviAViewController ()

@property (nonatomic, strong) NaviBViewController *bVC;

@end

@implementation NaviAViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.bVC = [NaviBViewController new];
    
    //设置BackBarItem侧滑有效
    [self setupBackBarItem];
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
    [self.navigationController pushViewController:self.bVC animated:YES];
}

#pragma mark - 侧滑返回

- (void)setupBackBarItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    back.title = @"A的返回";
    [self.navigationItem setBackBarButtonItem:back];
}


#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
