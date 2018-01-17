//
//  IQKeyBoardBugsViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/12/13.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "IQKeyBoardBugsViewController.h"

#import "IQKeyBoardTextView.h"

@interface IQKeyBoardBugsViewController ()

@end

@implementation IQKeyBoardBugsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试Navigation";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [IQKeyBoardTextView show];
}


@end
