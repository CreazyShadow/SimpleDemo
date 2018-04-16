//
//  RunLoopUtility.m
//  SimpleApp
//
//  Created by wuyp on 2017/5/4.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RunLoopUtility.h"

#import <CoreFoundation/CoreFoundation.h>

#include <pthread.h>

dispatch_source_t gcd_timer;

@interface RunLoopUtility()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation RunLoopUtility

+ (void)crashRecycle {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    NSArray *allmodes = CFBridgingRelease(CFRunLoopCopyAllModes(runloop));
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"程序崩溃了" message:@"崩溃信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    while (1) {
        for (NSString *mode in allmodes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}

#pragma mark - 监听runloop状态

+ (void)observerRunloopStatus {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities , YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"------%lu", activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

#pragma mark - runloop

+ (void)testRunLoopRunMaching {
    RunLoopUtility *utility = [[RunLoopUtility alloc] init];
    utility.thread = [[NSThread alloc] initWithTarget:utility selector:@selector(threadAction) object:nil];
    [utility.thread start];
 
    [utility performSelector:@selector(threadTestMethod) onThread:utility.thread withObject:nil waitUntilDone:NO];
}

- (void)threadAction {
    NSLog(@"----%@", [NSRunLoop currentRunLoop]);
    
//    NSMachPort *port = [[NSMachPort alloc] init];
//    [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"++++++++++");
}

- (void)threadTestMethod {
    NSLog(@"------ %@", NSStringFromSelector(_cmd));
}

#pragma mark - 子线程runloop

+ (void)testThreadRunloop {
    [[RunLoopUtility new] serialQuqueRunloop];
}


- (void)serialQuqueRunloop {
    __block CFRunLoopRef serialRunLoop = NULL;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t serialQueue = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);

    dispatch_async(serialQueue, ^{
        NSLog(@"the task run int the thread: %@", [NSThread currentThread]);
        [NSTimer scheduledTimerWithTimeInterval: 0.5 repeats: YES block: ^(NSTimer * _Nonnull timer) {
            NSLog(@"ns timer in the thread: %@", [NSThread currentThread]);
        }];
        
        serialRunLoop = [NSRunLoop currentRunLoop].getCFRunLoop;
        [[NSRunLoop currentRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow: 600]];
    });
    
    gcd_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
    dispatch_source_set_timer(gcd_timer, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(gcd_timer, ^{
        dispatch_async(serialQueue, ^{
            NSLog(@"gcd timer in the thread: %@", [NSThread currentThread]);
        });
        
        CFRunLoopPerformBlock(serialRunLoop, NSDefaultRunLoopMode, ^{
            NSLog(@"perform block in thread: %@", [NSThread currentThread]);
        });
    });

    dispatch_resume(gcd_timer);
}



@end
