//
//  RecycleItemsPool.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/19.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RecycleItemsPool.h"

#import "RecyleScrollViewItem.h"

#pragma mark - pool cache item entity

@interface RecyclePoolCacheItems : NSObject

@property (nonatomic, copy) NSString *identify;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation RecyclePoolCacheItems

@end

#pragma mark - items pool

@interface RecycleItemsPool()

@property (nonatomic, strong) NSMutableDictionary<NSString *,Class> *identifyMap;

@property (nonatomic, strong) NSMutableArray<RecyclePoolCacheItems *> *cachePool;

@end

@implementation RecycleItemsPool

- (instancetype)init {
    if (self = [super init]) {
        self.identifyMap = [[NSMutableDictionary alloc] init];
        self.cachePool = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)registClass:(Class)itemClass identify:(NSString *)identify {
    [_identifyMap setObject:itemClass forKey:identify];
}

- (RecyleScrollViewItem *)dequeueResuableItemWithIdentify:(NSString *)identify {
    Class cls = _identifyMap[identify];
    if (cls) {
        RecyclePoolCacheItems *cache = [self cacheItemsForIdentify:identify];
        if (!cache || cache.items.count == 0) {
            return [[RecyleScrollViewItem alloc] initWithIdentify:identify];
        }
        
        RecyleScrollViewItem *item = cache.items.firstObject;
        [cache.items removeObject:item];
        return item;
    } else {
        return nil;
    }
}

- (void)cacheItem:(RecyleScrollViewItem *)item {
    [_identifyMap setObject:[item class] forKey:item.identify];
    
    RecyclePoolCacheItems *cache = [self cacheItemsForIdentify:item.identify];
    if (!cache || cache.items.count == 0) {
        cache.identify = item.identify;
        cache.items = [[NSMutableArray alloc] init];
        [cache.items addObject:item];
    } else {
        if (![cache.items containsObject:item]) {
            [cache.items addObject:item];
        }
    }
}

- (void)clearPool {
    [_identifyMap removeAllObjects];
    [_cachePool removeAllObjects];
}

- (void)clearCacheForIdentify:(NSString *)identify {
    [_identifyMap removeObjectForKey:identify];
    
    for (RecyclePoolCacheItems *item in _cachePool) {
        if ([item.identify isEqualToString:identify]) {
            [_cachePool removeObject:item];
        }
    }
}

- (void)clearCacheForItem:(RecyleScrollViewItem *)item {
    for (RecyclePoolCacheItems *item in _cachePool) {
        if ([item.items containsObject:item]) {
            [item.items removeObject:item];
        }
    }
}

- (RecyclePoolCacheItems *)cacheItemsForIdentify:(NSString *)identify {
    for (RecyclePoolCacheItems *item in _cachePool) {
        if ([item.identify isEqualToString:identify]) {
            return item;
        }
    }
    
    return nil;
}

@end
