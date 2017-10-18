//
//  RunLoopUtility.m
//  SimpleApp
//
//  Created by wuyp on 2017/5/4.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RunLoopUtility.h"

#import <CoreFoundation/CoreFoundation.h>

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



@end
