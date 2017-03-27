//
//  NaviBViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "NaviBViewController.h"

#import "CustomNavigationController.h"

@interface NaviBViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation NaviBViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //禁止侧滑手势和tableView同时滑动
    CustomNavigationController *navController = (CustomNavigationController *)self.navigationController;
    if ([navController screenEdgePanGestureRecognizer]) {
        //指定滑动手势在侧滑返回手势失效后响应
        [self.scrollview.panGestureRecognizer requireGestureRecognizerToFail:[navController screenEdgePanGestureRecognizer]];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - init subviews

- (void)initSubviews {
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 150)];
    _scrollview.backgroundColor = [UIColor whiteColor];
    _scrollview.contentSize = CGSizeMake(3 * kScreenWidth, 0);
    _scrollview.contentOffset = CGPointZero;
    [self.view addSubview:_scrollview];
    
    for (int i = 0; i < 3; i++) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, 150)];
        temp.text = [NSString stringWithFormat:@"第%d张画面", i];
        temp.font = [UIFont systemFontOfSize:30];
        temp.layer.borderColor = [UIColor purpleColor].CGColor;
        temp.layer.borderWidth = 1;
        [_scrollview addSubview:temp];
    }
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 120, 30)];
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"Previous" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - event

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
