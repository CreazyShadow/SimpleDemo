//
//  Cat.m
//  SimpleModel
//
//  Created by wuyp on 2017/1/5.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (void)cry {
    NSLog(@"%@ 喵喵", NSStringFromClass([self class]));
}

@end
