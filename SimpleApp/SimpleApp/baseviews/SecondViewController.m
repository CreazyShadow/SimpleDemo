//
//  SecondViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/6/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFRunLoop.h>

@interface SecondViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SecondViewController";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_timer) {
        [self stop];
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}

- (void)start {
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)stop {
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)timerRun {
    NSLog(@"~~~~~~~111~~~~~~~~~~");
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
