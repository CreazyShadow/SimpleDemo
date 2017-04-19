//
//  RecycleScrollView.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RecycleScrollView.h"
#import "RecyleScrollViewItem.h"
#import "RecycleItemsPool.h"

static NSInteger const kInitializedItemsCount = 3;
static CGFloat const kCriticalPrecent = 0.7;

@interface RecycleScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) RecycleItemsPool *itemsPool;

@end

@implementation RecycleScrollView
{
    NSInteger _currentPage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.itemsPool = [[RecycleItemsPool alloc] init];
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollview];
        _scrollview.delegate = self;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self loadItems:NO];
}

#pragma mark - init

- (void)loadItems:(BOOL)isReloadData {
    
    NSInteger didLoadedItemsCount = [self didLoadedItemCount];
    if (didLoadedItemsCount >= kInitializedItemsCount) {
        return;
    }
    
    CGFloat startX = didLoadedItemsCount * self.width;
    NSInteger count = [self pagesCount];
    NSInteger realCount = count > kInitializedItemsCount ? kInitializedItemsCount : count;
    
    if (realCount <= didLoadedItemsCount) { //items比较小
        return;
    } else { //items比以前多
        realCount -= didLoadedItemsCount;
    }
    
    for (int i = 0; i < realCount; i++) {
        RecyleScrollViewItem *item = [self itemForDataSource:i];
        NSAssert(item, @"item no allow nil");
        
        [self.scrollview addSubview:item];
        item.frame = CGRectMake(self.width * i + startX, 0, self.width, self.height);
    }
    
    _scrollview.contentSize = CGSizeMake(self.width * realCount , 0);
}

#pragma mark - public

- (void)reloadData {
    _scrollview.contentOffset = CGPointZero;
    [self loadItems:YES];
}

- (void)registClass:(Class)itemClass forItemIdentify:(NSString *)identify {
    [self.itemsPool registClass:itemClass identify:identify];
}

- (RecyleScrollViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identify {
    return [self.itemsPool dequeueResuableItemWithIdentify:identify];
}

#pragma mark - 复用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat oldPercent = 0;
    CGFloat percent = scrollView.contentOffset.x / scrollView.width;
    NSInteger current = floor(percent);
    
    if (percent > oldPercent) { //向后滑动
        
        if (_currentPage + 2 >= [self pagesCount]) {
            return;
        }

        if (current > floor(oldPercent)) {
            _currentPage += 1;
        }
        
        oldPercent = percent;
        if (_currentPage >= 1 && percent > 1 + kCriticalPrecent) {
            oldPercent -= 1;
            self.scrollview.contentOffset = CGPointMake(self.scrollview.contentOffset.x - self.scrollview.width, 0);
            [self scroll:NO];
        }
    } else if (percent < oldPercent) { //向前滑动
        
        if (_currentPage <= 0) {
            return;
        }
        
        if (current < floor(oldPercent)) {
            _currentPage -= 1;
        }
        
        oldPercent = percent;
        if (_currentPage >= 1 && percent < kCriticalPrecent) {
            oldPercent += 1;
            self.scrollview.contentOffset = CGPointMake(self.scrollview.contentOffset.x + self.scrollview.width, 0);
            [self scroll:YES];
        }
    }
    
    NSLog(@"---current:%ld", _currentPage);
}

- (void)scroll:(BOOL)isBefore {
    @synchronized (self) {
        RecyleScrollViewItem *needReplace = nil;
        for (UIView *item in self.scrollview.subviews) {
            if (![item isKindOfClass:[RecyleScrollViewItem class]]) {
                continue;
            }
            
            if (isBefore) {
                item.x = item.x + self.width;
                if (item.x == kInitializedItemsCount * self.width) {
                    item.x = 0;
                    needReplace = (RecyleScrollViewItem *)item;
                }
            } else {
                item.x = item.x - self.width;
                if (item.x == -self.width) {
                    item.x = (kInitializedItemsCount - 1) * self.width;
                    needReplace = (RecyleScrollViewItem *)item;
                }
            }
        }
        
        //替换对应的item
        [self renderNextItem:needReplace isBefore:isBefore];
    }
}

#pragma mark - private

- (RecyleScrollViewItem *)itemForDataSource:(NSInteger)page {
    if ([self.dataSource respondsToSelector:@selector(recycleScrollView:itemForPage:)]) {
        return [self.dataSource recycleScrollView:self itemForPage:page];
    }
    
    return nil;
}

- (Class)itemType {
    if ([self.dataSource respondsToSelector:@selector(itemClassInRecycleScrollView)]) {
        return [self.dataSource itemClassInRecycleScrollView];
    }
    
    return nil;
}

- (NSInteger)pagesCount {
    if ([self.dataSource respondsToSelector:@selector(numberOfPagesInRecyleScrollView)]) {
        return [self.dataSource numberOfPagesInRecyleScrollView];
    }
    
    return 0;
}

- (NSInteger)didLoadedItemCount {
    NSInteger i = 0;
    for (UIView *item in self.scrollview.subviews) {
        if ([item isKindOfClass:[RecyleScrollViewItem class]]) {
            i++;
        }
    }
    
    return i;
}

- (void)renderNextItem:(RecyleScrollViewItem *)item isBefore:(BOOL)isBefore {
    [item removeFromSuperview];
    [self.itemsPool cacheItem:item];
    
    RecyleScrollViewItem *new = [self itemForDataSource:isBefore ? _currentPage - 1 : _currentPage + 2];
    new.frame = item.frame;
    [self.scrollview addSubview:new];
}

@end
