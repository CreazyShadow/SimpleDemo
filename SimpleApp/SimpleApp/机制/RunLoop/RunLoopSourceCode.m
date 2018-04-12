//
//  RunLoopSourceCode.m
//  SimpleApp
//
//  Created by wuyp on 2017/10/16.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RunLoopSourceCode.h"
#import <CoreFoundation/CoreFoundation.h>

@implementation RunLoopSourceCode


/**
 * CFRunLoopRef、CFRunLoopModeRef、CFRunLoopSourceRef、CFRunLoopTimerRef、CFRunLoopObserverRef
 * kCFRunLoopDefaultMode、kCFRunLoopCommonModes、UITrackingRunLoopMode
 *
 *
 */
- (void)runloopSource {

    
}

/// 用DefaultMode方式启动
void CFRunLoopRun(void) {
    CFRunLoopRunSepcific(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, 1.0e10, false);
}

/// 用指定的Mode启动，允许设置RunLoop超时时间
//int CFRunLoopRunInMode(CFStringRef modeName, CFTimeInterval seconds, Boolean stopAfterHandle) {
//    return CFRunLoopRunSepcific(CFRunLoopGetCurrent(), modeName, seconds, stopAfterHandle);
//}

int CFRunLoopRunSepcific(CFRunLoopRef runloop, CFStringRef modeName, CFTimeInterval seconds, Boolean stopAfterHandle) {
//    //根据modeName找到对应的mode
//    CFRunLoopModeRef currentMode = __CFRunLoopFindMode(runloop, modeName, false);
//    
//    //如果mode中没有source、timer、observer
//    if(__CFRunLoopModeIsEmpty(currentMode)) return 0;
//    
//    //1.通知observer runloop即将进入loop
//    __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopEntry);
//    
//    //进入RunLoop
//    __CFRunLoopRun(runloop, currentMode, seconds, returnAfterSourceHandled) {
//        Boolean sourceHandledThisLoop = NO;
//        int relVal = 0;
//        do {
//            // 2.通知Observer RunLoop即将出发timer回调
//            __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopBeforeTimers);
//            
//            // 3.通知observers：Runloop即将触发source0回调
//            __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopBeforeSources);
//            
//            //执行加入的block
//            __CFRunLoopDoBlocks(runloop, currentMode);
//            
//            // 4.触发source0的回调
//            sourceHandledThisLoop = __CFRunLoopDoSources0(runloop, currentMode, stopAfterHandle);
//            
//            //执行加入的block
//            __CFRunLoopDoBlocks(runloop, currentMode);
//            
//            //5.如果有source1（基于port）处于ready状态，直接处理source1然后跳转处理消息
//            if (__Source0DidDispatchPortLastTime) {
//                Boolean hasMsg = __CFRunLoopServiceMachPort(dispatchPort, &msg);
//                if (hasMsg) goto handle_msg;
//            }
//            
//            // 通知observers：RunLoop即将进入休眠
//            if(!sourceHandledThisLoop) {
//                __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopBeforeWaiting);
//            }
//            
//            // 7.调用mach_msg 等待接收mach_port的消息。线程即将进入休眠，知道被下面一个事件唤醒
//            /// • 一个基于 port 的Source 的事件。
//            /// • 一个 Timer 到时间了
//            /// • RunLoop 自身的超时时间到了
//            /// • 被其他什么调用者手动唤醒
//            __CFRunLoopServiceMachPort(waitSet, &msg, sizeof(msg_buffer), &livePort) {
//                mach_msg(msg, MACH_RCV_MSG, port);
//            }
//            
//            // 8.通知Observers：RunLoop刚刚被唤醒
//            __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopAfterWaiting);
//            
//            // 收到消息，处理消息
//        handle_msg:
//            
//            //9.1 如果一个timer时间到了 处理timer回调
//            if (msg_is_timer) {
//                __CFRunLoopDoTimers(runloop, currentMode, mach_absoulte_time());
//            }
//            
//            //9.2 如果有dispatch到main thread的block 处理block
//            else if (msg_is_dispatch) {
//                __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(msg);
//            }
//            
//            //9.3 如果有一个source1发出事件，处理这个事件
//            else {
//                CFRunLoopSourceRef source1 = __CFRunLoopModeFindSourceForMachPort(runloop, currentMode, livePort);
//                sourceHandledThisPort = __CFRunLoopDoSource1(runloop, currentMode, source1, msg);
//                if (sourceHandledThisPort) {
//                    mach_msg(reply, MACH_SEND_MSG, reply);
//                }
//            }
//            
//            //执行加入到Loop的block
//            __CFRunLoopDoBlocks(runloop, currentMode);
//            
//            if (sourceHandledThisLoop && stopAfterHandle) {
//                // 进入loop时参数说处理完事件就返回
//                retVal = kCFRunLoopRunHandledSource;
//            } else if (timeout) {
//                // 传入参数超时标记
//                retVal = kCFRunLoopRunTimedOut;
//            } else if (__CFRunLoopIsStopped(runloop)) {
//                //被外部调用者强行停止
//                retVal = kCFRunLoopRunStopped;
//            } else if (__CFRunLoopModeIsEmpty(runloop, currentMode)) {
//                //没有需要处理的source、timer、observer
//                retVal = kCFRunLoopRunFinished;
//            }
//        } while(retVal == 0);//如果
//        
//        __CFRunLoopDoObservers(r1, currentMode, kCFRunLoopExit);
//    }
    return 0;
}

#pragma mark - Mach

@end
