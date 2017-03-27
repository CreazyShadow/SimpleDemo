//
//  SortHelper.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/22.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "SortHelper.h"

static NSComparisonResult(^_compare)(id obj1, id obj2);

@implementation SortHelper

+ (SortHelper *(^)(void))instance {
    static dispatch_once_t onceToken;
    static SortHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SortHelper alloc] init];
    });
    
    return ^SortHelper *{ return instance; };
}

#pragma mark - 冒泡排序

#pragma mark - 选择排序

#pragma mark - 插入排序

#pragma mark - 归并排序

+ (NSArray *)mergerSort:(NSArray *)arr withCompareBlock:(NSComparisonResult (^)(id, id))block {
    _compare = [block copy];
    NSMutableArray *result = [NSMutableArray arrayWithArray:arr];
    [SortHelper.instance mergerSplit:result start:0 end:arr.count - 1];
    return result;
}

//拆分子集
- (void)mergerSplit:(NSMutableArray *)arr start:(NSInteger)start end:(NSInteger)end {
    if (start < end) {
        NSInteger mid = (start + end) / 2;
        [self mergerSplit:arr start:start end:mid];
        [self mergerSplit:arr start:mid + 1 end:end];
        [self mergerSubSort:arr left:start mid:mid end:end];
    }
}

//合并子集
- (void)mergerSubSort:(NSMutableArray *)arr left:(NSInteger)left mid:(NSInteger)mid end:(NSInteger)end {
    NSInteger i = 0;
    NSInteger j = 0;
    
    NSArray *leftArr = [arr subarrayWithRange:NSMakeRange(left, mid - left + 1)];
    NSArray *rightArr = [arr subarrayWithRange:NSMakeRange(mid + 1, end - mid + 1)];
    for (NSInteger k = left; k < end; k++) {
        if (_compare(arr[i], arr[j]) == NSOrderedAscending && i < mid - left + 1) {
            arr[k] = leftArr[i];
            i++;
        } else if (j < end - mid + 1) {
            arr[k] = rightArr[j];
            j++;
        }
    }
}

@end
