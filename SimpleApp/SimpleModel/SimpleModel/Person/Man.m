//
//  Man.m
//  SimpleModel
//
//  Created by wuyp on 2016/12/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "Man.h"

@implementation Man

- (id)copyWithZone:(NSZone *)zone {
    Man *man = [[self class] allocWithZone:zone];
    man.name = self.name;
    return man;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    Man *man = [[self class] allocWithZone:zone];
    man.name = [self.name copy];
    return man;
}

@end
