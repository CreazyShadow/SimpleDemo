//
//  UIWindow+FlexSetting.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/11.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "UIWindow+FlexSetting.h"

//#if DEBUG
#import <FLEXManager.h>
//#endif

@implementation UIWindow (FlexSetting)

#if DEBUG

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];
    }
}

#endif

@end
