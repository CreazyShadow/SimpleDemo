//
//  GestureSummary_ResponseTime.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/11.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "GestureSummary_ResponseTime.h"

@implementation GestureSummary_ResponseTime

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)ges {
    NSLog(@"------%@", [NSDate date]);
}

@end
