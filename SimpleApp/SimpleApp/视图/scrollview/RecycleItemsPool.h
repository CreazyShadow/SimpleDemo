//
//  RecycleItemsPool.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/19.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecyleScrollViewItem;

@interface RecycleItemsPool : NSObject

- (void)registClass:(Class)itemClass identify:(NSString *)identify;

- (RecyleScrollViewItem *)dequeueResuableItemWithIdentify:(NSString *)identify;

- (void)cacheItem:(RecyleScrollViewItem *)item;

- (void)clearPool;

- (void)clearCacheForIdentify:(NSString *)identify;

- (void)clearCacheForItem:(RecyleScrollViewItem *)item;

@end
