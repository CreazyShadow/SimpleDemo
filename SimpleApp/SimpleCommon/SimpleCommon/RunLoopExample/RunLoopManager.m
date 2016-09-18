//
//  RunLoopManager.m
//  SimpleCommon
//
//  Created by wuyp on 16/6/6.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "RunLoopManager.h"
#import <CoreFoundation/CoreFoundation.h>

//typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
//    kCFRunLoopEntry         = (1UL << 0), // 即将进入Loop
//    kCFRunLoopBeforeTimers  = (1UL << 1), // 即将处理 Timer
//    kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
//    kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
//    kCFRunLoopAfterWaiting  = (1UL << 6), // 刚从休眠中唤醒
//    kCFRunLoopExit          = (1UL << 7), // 即将退出Loop
//};

//struct __CFRunLoopMode {
//    CFStringRef _name;            // Mode Name, 例CFRunLoopRunSpecific如 @"kCFRunLoopDefaultMode"
//    CFMutableSetRef _sources0;    // Set
//    CFMutableSetRef _sources1;    // Set
//    CFMutableArrayRef _observers; // Array
//    CFMutableArrayRef _timers;    // Array
//    ...
//};

//struct __CFRunLoop {
//    CFMutableSetRef _commonModes;     // Set
//    CFMutableSetRef _commonModeItems; // Set<Source/Observer/Timer>
//    CFRunLoopModeRef _currentMode;    // Current Runloop Mode
//    CFMutableSetRef _modes;           // Set
//    ...
//};

@implementation RunLoopManager

- (void)executeEvent {
    
}

@end
