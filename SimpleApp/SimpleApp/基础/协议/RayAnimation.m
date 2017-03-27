//
//  RayAnimation.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/13.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RayAnimation.h"

@implementation RayAnimation

- (void)createAnimation:(NSString *)name eat:(NSString *)eat {
    
}

- (void)introduce:(id<RayAnimation>)animation {
    NSLog(@"name:%@ eat:%@", animation.name, animation.eat);
}

@end
