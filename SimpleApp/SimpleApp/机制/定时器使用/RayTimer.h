//
//  RayTimer.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RayTimer : NSObject

+ (RayTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeat:(BOOL)repeat;

+ (RayTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval repeat:(BOOL)repeat block:(void(^)())block;

- (void)start;

- (void)stop;

+ (void)printBlock:(void(^)(void))block;

@end
