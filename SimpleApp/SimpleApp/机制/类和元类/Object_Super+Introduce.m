//
//  Object_Super+Introduce.m
//  SimpleApp
//
//  Created by wuyp on 2017/6/21.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Object_Super+Introduce.h"

@implementation Object_Super (Introduce)

- (void)introduce {
    NSLog(@"----Category:%@", [self class]);
}

@end
