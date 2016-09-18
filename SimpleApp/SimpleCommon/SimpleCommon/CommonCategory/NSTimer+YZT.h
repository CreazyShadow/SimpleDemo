//
//  NSTimer+YZT.h
//  SimpleCommon
//
//  Created by wuyp on 16/7/14.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YZT)

+ (NSTimer *)yzt_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats;

+ (NSTimer *)yzt_timerWithTimeInterval:(NSTimeInterval)interval
                                 block:(void(^)())block
                               repeats:(BOOL)repeats;
// 开始
- (void)yzt_start;
// 暂停
- (void)yzt_pause;


#pragma mark - execute time

+ (double)yzt_measureExecutionTime:(void (^)())block;

+ (void)yzt_startTiming;
+ (double)yzt_timeInterval;

@end
