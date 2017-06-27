//
//  CategoryViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/6/21.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "CategoryViewController.h"

#import "Object_Super.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Object_Super *obj = [[Object_Super alloc] init];
    [obj introduce];
}

@end
