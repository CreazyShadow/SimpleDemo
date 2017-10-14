//
//  Person.m
//  SimpleModel
//
//  Created by wuyp on 16/8/19.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)test {
    self.name = @"123";
}

- (NSString *)phoneNum {
    if (_phoneNum.length == 0) {
        return @"18516518602";
    }
    
    return _phoneNum;
}

#pragma mark - 消息

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

- (NSUInteger)hash {
    NSUInteger temp = [super hash];
    NSLog(@"-----hash:%ud", temp);
    return temp;
}

@end
