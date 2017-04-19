//
//  LoadChartDataSource.m
//  SimpleCommon
//
//  Created by wuyp on 2017/4/1.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "LoadChartDataSource.h"

static NSInteger const kEachGetData = 2;

@interface LoadChartDataSource()

@property (nonatomic, strong) NSMutableArray *cacheSource;

@end

@implementation LoadChartDataSource

#pragma mark - public

- (NSArray *)sourceWithIndex:(NSInteger)index {
    if (self.cacheSource.count < index + kEachGetData) { //请求数据
        
    } else {
        [self.cacheSource subarrayWithRange:NSMakeRange(index, kEachGetData)];
    }
    
    return nil;
}

#pragma mark - private

#pragma mark - getter & setter

- (NSMutableArray *)cacheSource {
    if (!_cacheSource) {
        _cacheSource = [[NSMutableArray alloc] init];
    }
    
    return _cacheSource;
}


@end
