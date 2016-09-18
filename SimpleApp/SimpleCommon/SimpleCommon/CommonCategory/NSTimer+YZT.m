//
//  NSTimer+YZT.m
//  SimpleCommon
//
//  Created by wuyp on 16/7/14.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "NSTimer+YZT.h"

@implementation NSTimer (YZT)

+ (NSTimer *)yzt_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(yzt_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (NSTimer *)yzt_timerWithTimeInterval:(NSTimeInterval)interval
                                 block:(void(^)())block
                               repeats:(BOOL)repeats{
    return [self timerWithTimeInterval:interval
                                target:self
                              selector:@selector(yzt_blockInvoke:)
                              userInfo:[block copy]
                               repeats:YES];
}

+ (void)yzt_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if(block) {
        block();
    }
}

- (void)yzt_start {
    [self setFireDate:[NSDate distantPast]];
}

- (void)yzt_pause {
    [self setFireDate:[NSDate distantFuture]];
}

#pragma mark - execute time

+ (double)yzt_measureExecutionTime:(void (^)())block
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    block();
    
    double executionTime = CFAbsoluteTimeGetCurrent() - startTime;
    return executionTime;
}

static CFAbsoluteTime g_s_jj_startTime;

+ (void)yzt_startTiming
{
    g_s_jj_startTime = CFAbsoluteTimeGetCurrent();
}

+ (double)yzt_timeInterval
{
    double startTime = g_s_jj_startTime;
    g_s_jj_startTime = CFAbsoluteTimeGetCurrent();
    double timeInterval = g_s_jj_startTime - startTime;
    
    return timeInterval;
}

@end
