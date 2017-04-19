//
//  RecycleScrollView.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RecycleScrollView.h"
#import "RecyleScrollViewItem.h"

static NSInteger const kInitializedItemsCount = 3;
static CGFloat const kCriticalPrecent = 0.7;

@interface RecycleScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) NSMutableDictionary<NSString *, RecyleScrollViewItem *> *itemsPool;

@end

@implementation RecycleScrollView
{
    NSInteger _currentPage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.itemsPool = [[NSMutableDictionary alloc] init];
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollview];
        _scrollview.delegate = self;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self initializedItems];
}

#pragma mark - init

- (void)initializedItems {
    for (int i = 0; i < kInitializedItemsCount; i++) {
        RecyleScrollViewItem *item = [self itemForDataSource:i];
        if (!item) {
            item = [RecyleScrollViewItem new];
        }
        
        [self.scrollview addSubview:item];
        item.frame = CGRectMake(self.width * i, 0, self.width, self.height);
    }
    
    NSInteger count = [self pagesCount];
    _scrollview.contentSize = CGSizeMake(self.width * (kInitializedItemsCount > count ? count : kInitializedItemsCount) , 0);
}

#pragma mark - public

- (void)reloadData {
    [self initializedItems];
}

- (void)registClass:(Class)itemClass forItemIdentify:(NSString *)identify {
    if (![self.itemsPool.allKeys containsObject:identify]) {
        
    }
}

- (RecyleScrollViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identify {
    for (RecyleScrollViewItem *item in self.itemsPool) {
        if ([item.identify isEqualToString:identify]) {
//            [self.itemsPool removeObject:item];
            return item;
        }
    }
    
    RecyleScrollViewItem *item = [[RecyleScrollViewItem alloc] init];
//    [self.itemsPool addObject:item];
    return item;
}

#pragma mark - 复用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat oldPercent = 0;
    CGFloat percent = scrollView.contentOffset.x / scrollView.width;
    NSInteger current = floor(percent);
    
    if (percent > oldPercent) { //向后滑动
        
        if (_currentPage + 1 >= [self pagesCount]) {
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

- (NSInteger)pagesCount {
    if ([self.dataSource respondsToSelector:@selector(numberOfPagesInRecyleScrollView)]) {
        return [self.dataSource numberOfPagesInRecyleScrollView];
    }
    
    return 0;
}

- (void)renderNextItem:(RecyleScrollViewItem *)item isBefore:(BOOL)isBefore {
    RecyleScrollViewItem *new = [self itemForDataSource:isBefore ? _currentPage - 1 : _currentPage + 2];
    new.frame = item.frame;
    [self.scrollview addSubview:new];
}

@end
