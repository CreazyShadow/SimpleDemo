//
//  DrawViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/10/24.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "DrawViewController.h"
#import "DelayDrawView.h"

#import "tailorView.h"

@interface DrawViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DelayDrawView *delayView;

@property (nonatomic, strong) TailorView *tailorView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TailorView *tailor = [[TailorView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 200)];
    tailor.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:tailor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - delay draw path

- (void)delayDrawPath:(UIColor *)color {
    DelayDrawView *view = [[DelayDrawView alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
    view.backgroundColor = color;
    [self.view addSubview:view];
    self.delayView = view;
}

@end
