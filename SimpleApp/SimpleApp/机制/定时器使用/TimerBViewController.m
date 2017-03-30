//
//  TimerBViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TimerBViewController.h"

#import "RayTimer.h"

@interface TimerBViewController ()

@property (nonatomic, strong) RayTimer *timer;

@property (nonatomic, assign) NSInteger repeatCount;

@end

@implementation TimerBViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self startRayTimerWithBlock];
//    [self startRayTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    if (_timer) {
        [_timer stop];
    }
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) weakSelf = self;
    [RayTimer printBlock:^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        [weakSelf run];
    }];
}

#pragma mark - network

#pragma mark - private

- (void)startRayTimer {
    __weak typeof(self) weakSelf = self;
    _timer = [RayTimer scheduledTimerWithTimerInterval:1 target:weakSelf selector:@selector(run) userInfo:nil repeat:YES];
}

- (void)startRayTimerWithBlock {
    __weak typeof(self) weakSelf = self;
   _timer = [RayTimer scheduledTimerWithTimerInterval:1 repeat:YES block:^{
        [weakSelf run];
    }];
}

- (void)run {
    NSLog(@"%@ timer run....", NSStringFromClass([self class]));
    self.repeatCount++;
}

#pragma mark - getter & setter

@end
