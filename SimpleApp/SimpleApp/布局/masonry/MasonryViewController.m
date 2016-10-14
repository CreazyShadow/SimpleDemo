//
//  MasonryViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/9.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "MasonryViewController.h"

#import <Masonry.h>

@interface MasonryViewController ()

@property (nonatomic, strong) UIButton *eventButton;

@property (nonatomic, strong) MASConstraint *centerConstraint;

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButton];
}

- (void)setupButton {
    self.eventButton = [[UIButton alloc] init];
    _eventButton.backgroundColor = [UIColor blueColor];
    [_eventButton setTitle:@"Event" forState:UIControlStateNormal];
    [self.view addSubview:_eventButton];
    
    [_eventButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(100);
    }];
    
    _eventButton.titleLabel.backgroundColor = [UIColor redColor];
    [_eventButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
}

@end
