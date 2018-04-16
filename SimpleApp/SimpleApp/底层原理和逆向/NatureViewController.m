//
//  NatureViewController.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/16.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "NatureViewController.h"
#import "NatureClass.h"

@interface NatureViewController ()

@end

@implementation NatureViewController

#pragma mark - life cycle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark - subviews

#pragma mark - event responder

- (IBAction)ClassNatureAction:(id)sender {
    [[NatureClass new] testNature];
}

#pragma mark - network

#pragma mark - tableview delegate & datasource

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

@end
