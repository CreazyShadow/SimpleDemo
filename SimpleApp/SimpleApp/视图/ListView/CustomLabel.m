//
//  CustomLabel.m
//  SimpleApp
//
//  Created by wuyp on 2018/1/26.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (frame.origin.x == 0) {
        NSLog(@"------frame 0");
    }
}

@end
