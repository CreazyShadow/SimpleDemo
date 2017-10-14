//
//  PerformanceViewController.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "PerformanceViewController.h"

#include <sys/sysctl.h>

@interface PerformanceViewController ()

@end

@implementation PerformanceViewController
{
    int _scheduleTimes;
    CFTimeInterval _timestamp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - CPU

void cpu() {
    int result = 0;
    int mib[2] = {0};
    mib[0] = CTL_HW;
    mib[1] = HW_CPU_FREQ;
    size_t length = sizeof(result);
    if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
    {
        perror("getting cpu frequency");
    }
    
    printf("%d", result);
}

#pragma mark - FPS

- (void)startMonitorFPS {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkRun:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkRun:(CADisplayLink *)link {
    _scheduleTimes++;
    if (_timestamp == 0) {
        _timestamp = link.timestamp;
    }
    
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    if (_timestamp >= 1.f) {
        CGFloat fps = _scheduleTimes / timePassed;
        NSLog(@"%.1f", fps);
    }
}

#pragma mark - 启动时间

/**
 *  启动时间t = t1(main()之前时间) + t2(main()之后时间)
 *  t1：系统动态链接库 + 项目中的可执行文件加载
 *  t2: AppDelegate中
 *
 */

#pragma mark - UI线程安全 防止crash和动画丢失

/**
 *  通过分类的方式hook UIView的setNeedsLayout setNeedsDisplay setNeedsDisplayInRect
 */

#pragma mark - 

@end
