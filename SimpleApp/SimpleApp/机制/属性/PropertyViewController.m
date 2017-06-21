//
//  PropertyViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/6/12.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "PropertyViewController.h"

#import "PhoneNumPerson.h"

@interface PropertyViewController ()

@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PhoneNumPerson *person = [[PhoneNumPerson alloc] init];
    NSLog(@"---%@", person.phoneNum);
    
    person.phoneNum = @"111111111111";
    person.phoneNum = @"111111111111";
    NSLog(@"---%@", person.phoneNum);
}


@end
