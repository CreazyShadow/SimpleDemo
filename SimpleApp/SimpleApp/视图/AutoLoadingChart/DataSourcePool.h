//
//  DataSourcePool.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataSourcePool;

@protocol DataSourceItemProtocol <NSObject>

@end

@protocol DataSourcePoolDelegate <NSObject>

- (void)dataSourcePoolRequestSource:(DataSourcePool *)pool success:(void(^)(NSArray *source))callback;

@end

@interface DataSourcePool : NSObject

@property (nonatomic, assign) int eachCount;

@property (nonatomic, weak) id<DataSourcePoolDelegate> delegate;

+ (instancetype)sharePool;

- (void)setupDataSource:(NSArray *)source;

- (id)sourceByCurrentIndex:(int)index;

@end
