//
//  ScrollViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/16.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation ScrollViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
    [self.view addSubview:_scrollview];
    
    _scrollview.contentSize = CGSizeMake(kScreenWidth, 0);
    _scrollview.backgroundColor = [UIColor orangeColor];
    
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

- (void)setupSubviews {
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(-100, 0, 100, 30)];
    lbl.backgroundColor = [UIColor redColor];
    [_scrollview addSubview:lbl];
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    l2.backgroundColor = [UIColor greenColor];
    [_scrollview addSubview:l2];
    
    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectMake(250, 50, 100, 30)];
    l3.backgroundColor = [UIColor yellowColor];
    [_scrollview addSubview:l3];
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _scrollview.layer.transform = CATransform3DMakeRotation(M_PI_2 * 2, 0, 1, 0);
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
