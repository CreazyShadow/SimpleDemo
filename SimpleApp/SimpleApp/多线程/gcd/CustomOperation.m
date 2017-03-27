//
//  CustomOperation.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/17.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "CustomOperation.h"

typedef NS_ENUM(NSInteger, State) {
    Ready,
    Executing,
    Finish
};

@implementation CustomOperation
{
    State _state;
}

- (BOOL)isExecuting {
    return _state == Executing;
}

- (BOOL)isFinished {
    return _state == Finish;
}

- (void)start {
    if (self.isCancelled) {
        _state = Finish;
        return;
    }
    
    _state = Executing;
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
}

//do something
- (void)main {
    
}

@end
