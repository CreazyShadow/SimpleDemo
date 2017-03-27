//
//  ClassicsArithmetic.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ClassicsArithmetic.h"

@implementation ClassicsArithmetic

+ (NSInteger)selectedIndexWithTotalCount:(NSInteger)total range:(NSInteger)range {
    NSParameterAssert(range >= 1);
    
    NSMutableArray *source = [NSMutableArray arrayWithCapacity:total];
    for (int i = 0; i < total; i++) {
        [source addObject:@"1"];
    }
    
    [self circleSelect:source range:range circleStartLen:0];
    __block NSInteger original = -1;
    [source enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj length] > 0) {
            original = idx;
        }
    }];
    
    return original < 0 ? source.count : original + 1;
}

+ (void)circleSelect:(NSMutableArray *)source range:(NSInteger)range circleStartLen:(NSInteger)circleStartIndex {
    NSInteger validCircelCount = circleStartIndex;//有效的循环
    NSInteger validCount = 0;
    NSInteger lastFitIndex = -1;
    for (NSInteger i = 1; i <= source.count; i++) {
        if ([source[i - 1] length] > 0) {
            validCircelCount++;
            validCount++;
        }
        
        if (validCircelCount == range) {
            source[i - 1] = @"";
            validCircelCount = 0;
            lastFitIndex = i;
        }
    }
    
    if (validCount <= 1) {
        if (lastFitIndex >= 0 && lastFitIndex < source.count) {
            source[lastFitIndex] = @"1";
        }
        
        return;
    }
    
    [self circleSelect:source range:range circleStartLen:validCircelCount];
}

@end
