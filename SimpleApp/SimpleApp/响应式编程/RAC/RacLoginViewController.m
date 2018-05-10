//
//  RacLoginViewController.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/7.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "RacLoginViewController.h"

#import <ReactiveObjC.h>

@interface RacLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation RacLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置绑定信号

- (void)bindingSingle {
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"---click login btn");
        [WSProgressHUD showWithStatus:@"登录成功"];
    }];
}

@end
