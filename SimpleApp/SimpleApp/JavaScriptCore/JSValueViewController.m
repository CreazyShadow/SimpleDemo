//
//  JSValueViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/8.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "JSValueViewController.h"

#import "JSContextDemo.h"

@interface JSValueViewController ()

@end

@implementation JSValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    view.backgroundColor = [UIColor blueColor];
    view.layer.cornerRadius = 25;
    view.layer.borderColor = [UIColor purpleColor].CGColor;
    view.layer.borderWidth = 10;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
