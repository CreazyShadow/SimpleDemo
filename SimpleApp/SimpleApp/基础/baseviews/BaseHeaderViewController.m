//
//  BaseHeaderViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "BaseHeaderViewController.h"

@interface BaseHeaderViewController ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *headerBtns;

@end

@implementation BaseHeaderViewController

#pragma mark - life cycle

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 256) / 255.0 green:(arc4random() % 256) / 255.0 blue:(arc4random() % 256) / 255.0 alpha:1];
    
    [self setupHeaderBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.navigationController) {
        self.view.frame = CGRectMake(0, 64 + 50, kScreenWidth, kScreenHeight - 114);
    } else {
        self.view.frame = CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50);
    }
}

#pragma mark - init subviews

- (void)setupHeaderBtn {
    _headerBtns = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, -50, kScreenWidth, 50)];
    container.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:container];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:[NSString stringWithFormat:@"test%d", i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor purpleColor];
        [btn addTarget:self action:@selector(clickHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn];
        [_headerBtns addObject:btn];
    }
    
    [_headerBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.equalTo(container.mas_top).offset(0);
    }];
    [_headerBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:8 leadSpacing:0 tailSpacing:0];
}

#pragma mark - event

- (void)clickHeaderAction:(UIButton *)btn {
    [self selectHeaderAction:[_headerBtns indexOfObject:btn]];
}

- (void)selectHeaderAction:(NSInteger)index {
    
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

- (void)setHeaderSource:(NSArray<NSString *> *)headerSource {
    _headerSource = headerSource;
    
    for (int i = 0; i < headerSource.count && i < _headerBtns.count; i++) {
        [_headerBtns[i] setTitle:headerSource[i] forState:UIControlStateNormal];
    }
}

@end
