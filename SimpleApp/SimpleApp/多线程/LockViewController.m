

//
//  LockViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/5/9.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "LockViewController.h"

@interface LockViewController ()

@property (nonatomic, strong) NSCondition *lock;

@end

@implementation LockViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lock = [[NSCondition alloc] init];
}

- (void)selectHeaderAction:(NSInteger)index {
    switch (index) {
        case 0:
        {
            [_lock lock];
            [NSThread detachNewThreadWithBlock:^{
                NSLog(@"------1");
            }];
//            [_lock unlock];
        }
            break;
        case 1:
        {
            [NSThread detachNewThreadWithBlock:^{
                [_lock wait];
                NSLog(@"------2");
            }];
        }
            break;
        case 2:
        {
            [_lock lock];
            [NSThread detachNewThreadWithBlock:^{
                NSLog(@"------3");
            }];
            [_lock unlock];
        }
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


@end
