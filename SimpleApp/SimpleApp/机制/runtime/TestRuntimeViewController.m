//
//  TestRuntimeViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/5/25.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestRuntimeViewController.h"
//#import "Dog.h"
#import "Dog+Fly.h"

@interface TestRuntimeViewController ()

@end

@implementation TestRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self testAddMethod];
//    [self testDogFlyProperty];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
//    TestRuntimeViewController *vc = [[TestRuntimeViewController alloc] init];
    UIViewController *vc = window.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).topViewController;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - addMethod

- (void)testAddMethod {
    Dog *dog = [[Dog alloc] init];
    [dog eat];
}

#pragma mark - category property

- (void)testDogFlyProperty {
    Dog *dog = [[Dog alloc] init];
    dog.flyType = @"curve fly";
    NSLog(@"dog fly type:%@", dog.flyType);
}

@end
