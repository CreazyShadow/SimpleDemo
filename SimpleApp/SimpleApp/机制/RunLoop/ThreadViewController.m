//
//  ThreadViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/20.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ThreadViewController.h"

#import <CoreFoundation/CoreFoundation.h>

#import "RunLoopUtility.h"

@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RunLoopUtility observerRunloopStatus];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    [self threadAlive];
    //    [self threadRunTimer];
    //    [self testCrash];
    
    
}

#pragma mark - 线程保活

- (void)threadAlive {
    [NSThread detachNewThreadWithBlock:^{
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addPort:[NSMachPort new] forMode:NSDefaultRunLoopMode];
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
}

#pragma mark - 子线程启动定时器

- (void)threadRunTimer {
    [NSThread detachNewThreadWithBlock:^{
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"-------run timer");
        }];
        [timer fire];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        [runloop run];
    }];
}

#pragma mark - RunLoop

- (void)testrunloop {
    
}

#pragma mark - runloop crash

- (void)testCrash {
    id arr = @[@1, @2, @3];
    [arr addObject:@4];
}

#pragma mark -

@end
