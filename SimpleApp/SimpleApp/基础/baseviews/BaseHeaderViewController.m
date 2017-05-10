//
//  BaseHeaderViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "BaseHeaderViewController.h"

#import "BaseView.h"

@interface BaseHeaderViewController ()

@end

@implementation BaseHeaderViewController

#pragma mark - life cycle

- (void)loadView {
    self.view = [[BaseView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 256) / 255.0 green:(arc4random() % 256) / 255.0 blue:(arc4random() % 256) / 255.0 alpha:1];
    __weak typeof(self) weakSelf = self;
    ((BaseView *)self.view).clickIndex = ^(NSInteger index) {
        [weakSelf selectHeaderAction:index];
    };
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


#pragma mark - event


- (void)selectHeaderAction:(NSInteger)index {
    
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

- (void)setHeaderSource:(NSArray<NSString *> *)headerSource {
    _headerSource = headerSource;
    
    [headerSource enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [((BaseView *)self.view) updateHeaderTitle:obj index:idx];
    }];
    
}
@end
