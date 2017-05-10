//
//  FirstBlockViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/19.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "FirstBlockViewController.h"

#import <Dog.h>

@interface FirstBlockViewController ()

@end

@implementation FirstBlockViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Dog *dog1 = [[Dog alloc] init];
    Dog *dog2 = dog1;
}

@end
