//
//  ClassA.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ClassA.h"

#import <objc/runtime.h>

#define __keyN(i) const void *key_i = &key_i

@implementation ClassA
{
    NSMutableDictionary *_d;
}

- (void)print {
    NSLog(@"----class A");
}


@end
