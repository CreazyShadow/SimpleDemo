//
//  Animal.m
//  SimpleModel
//
//  Created by wuyp on 2017/1/5.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (void)cry {
    NSLog(@"%@ cry", NSStringFromClass([self class]));
}

- (void)sleep {
    NSLog(@"----Animal sleep");
}

@end
