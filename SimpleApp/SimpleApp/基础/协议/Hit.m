//
//  Hit.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Hit.h"

@interface Hit : NSObject

- (void)hit;

@end

@implementation Hit

- (void)hit {
    NSLog(@"hit....");
}

- (void)say {
    NSLog(@"hit ---- say...");
}

@end
