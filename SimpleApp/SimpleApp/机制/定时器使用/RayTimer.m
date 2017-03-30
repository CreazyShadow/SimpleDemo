//
//  RayTimer.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RayTimer.h"

#import <objc/message.h>
#import <objc/runtime.h>

static NSString * const kAddMethodName = @"createMethodName";

@interface RayTimer()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL selector;

@property (nonatomic, copy) void(^runBlock)();

@end

@implementation RayTimer

+ (RayTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeat:(BOOL)repeat {
    
    RayTimer *rayTimer = [[RayTimer alloc] init];
    rayTimer.target = target;
    rayTimer.selector = selector;
    
    rayTimer.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:rayTimer selector:@selector(run) userInfo:userInfo repeats:YES];
    
    return rayTimer;
}

+ (RayTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval repeat:(BOOL)repeat block:(void (^)())block {
    RayTimer *rayTimer = [[RayTimer alloc] init];
    rayTimer.runBlock = [block copy];
    
    rayTimer.timer = [NSTimer scheduledTimerWithTimeInterval:interval repeats:repeat block:^(NSTimer * _Nonnull timer) {
        rayTimer.runBlock();
    }];
    
    return rayTimer;
}

- (void)start {
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)stop {
    [_timer setFireDate:[NSDate distantFuture]];
    
    [_timer invalidate];
}

#pragma mark - private

+ (RayTimer *)timerWithRuntime:(NSTimeInterval)interval target:(id)target selector:(SEL)selector {
    RayTimer *timer = [[RayTimer alloc] init];
    
    Method original = class_getInstanceMethod([target class], selector);
    const char *type = method_getTypeEncoding(original);
    IMP imp = method_getImplementation(original);
    BOOL isAdd = class_addMethod([timer class], NSSelectorFromString(kAddMethodName), imp, type);
    
    timer.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:timer selector:NSSelectorFromString(kAddMethodName) userInfo:nil repeats:YES];
    
    return timer;
}

#pragma mark - timer run

- (void)run {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.selector withObject:nil];
#pragma clang diagnostic pop
}


+ (void)printBlock:(void (^)(void))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
