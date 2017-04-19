//
//  DataSourcePool.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "DataSourcePool.h"

@interface DataSourcePool()

@property (nonatomic, strong) NSMutableArray *sourcePool;

@end

@implementation DataSourcePool

+ (instancetype)sharePool {
    static DataSourcePool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataSourcePool alloc] init];
        instance.sourcePool = [[NSMutableArray alloc] init];
    });
    
    return instance;
}

- (void)setupDataSource:(NSArray *)source {
    self.sourcePool = [[NSMutableArray alloc] initWithArray:source];
}

- (NSArray *)sourceByCurrentIndex:(int)index {
    if ([self judgeHasDataSource:index]) {
        return [self.sourcePool subarrayWithRange:NSMakeRange(index, self.eachCount)];
    }
    
    //请求数据
    __weak typeof(self) weakSelf = self;
    [self.delegate dataSourcePoolRequestSource:self success:^(NSArray *source) {
        [weakSelf.sourcePool addObjectsFromArray:source];
    }];
    
    return nil;
}

#pragma mark - private

- (BOOL)judgeHasDataSource:(int)index {
    if (self.sourcePool.count >= index + self.eachCount) {
        return YES;
    }
    
    return NO;
}

#pragma mark - getter & setter 

- (int)eachCount {
    return _eachCount ?: 2;
}

@end
