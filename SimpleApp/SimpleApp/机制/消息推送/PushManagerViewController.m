//
//  PushManagerViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "PushManagerViewController.h"

#import "PushManager.h"

@interface PushManagerViewController ()

@end

@implementation PushManagerViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

- (void)setupSubViews {
    UIButton *localBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 100, 30)];
    [localBtn setTitle:@"本地推送" forState:UIControlStateNormal];
    localBtn.backgroundColor = [UIColor purpleColor];
    [localBtn addTarget:self action:@selector(localPushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localBtn];
    
    UIButton *remoteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, 100, 30)];
    [remoteBtn setTitle:@"远程推送" forState:UIControlStateNormal];
    remoteBtn.backgroundColor = [UIColor purpleColor];
    [remoteBtn addTarget:self action:@selector(remotePushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:remoteBtn];
}

#pragma mark - event

- (void)localPushAction {
    [[PushManager sharePushManager] registLocalPush];
}

- (void)remotePushAction {
    
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
