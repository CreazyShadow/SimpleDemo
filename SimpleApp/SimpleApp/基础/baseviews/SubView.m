//
//  SubView.m
//  SimpleApp
//
//  Created by wuyp on 16/11/8.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SubView.h"

@implementation SubView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"------- init subview");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"-------- init with frame subview");
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"-------init with coder");
    }
    return self;
}

@end
