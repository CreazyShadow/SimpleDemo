//
//  Dog+Fly.m
//  SimpleModel
//
//  Created by wuyp on 16/7/4.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "Dog+Fly.h"

#import <objc/runtime.h>

@implementation Dog (Fly)

- (NSString *)flyType {
    return objc_getAssociatedObject(self, @selector(flyType));
}

- (void)setFlyType:(NSString *)flyType {
    if (self.flyType != flyType) {
        objc_setAssociatedObject(self, @selector(flyType), flyType, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

@end
