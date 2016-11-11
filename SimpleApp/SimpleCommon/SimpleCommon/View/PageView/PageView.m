//
//  YZTPageView.m
//  popDemo
//
//  Created by chenlehui on 16/4/25.
//  Copyright © 2016年 chenlehui. All rights reserved.
//

#import "PageView.h"
#import <Masonry/Masonry.h>
#import "NSTimer+YZT.h"

@interface PageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableDictionary *registerItems;

@property (nonatomic, strong) NSMutableDictionary *reuseItems;

@property (nonatomic, strong) NSMutableArray *usingItems;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger pageNumber;

@property (nonatomic, assign, readwrite) NSInteger currentPage;

@property (nonatomic, assign) NSInteger realPage;

@property (nonatomic, assign) NSInteger prePage;

@property (nonatomic, assign) NSInteger aimPage;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) BOOL isReload;

@property (nonatomic, assign) BOOL isDragging;

@end

@implementation PageView

#pragma mark - lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self yzt_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self yzt_init];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.isReload) {
        self.isReload = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{            
            [self yzt_loadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.autoScrollInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.timer && self.timer.valid) {
                    [self.timer yzt_start];
                }
            });
        });
    }

}

- (void)dealloc {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _scrollView.delegate = nil;
}

#pragma mark - private

- (void)yzt_init {
    _registerItems = [NSMutableDictionary dictionaryWithCapacity:0];
    _reuseItems = [NSMutableDictionary dictionaryWithCapacity:0];
    _usingItems = [NSMutableArray array];
    _scrollEnabled = YES;
    _autoScrollEnabled = NO;
    _cycleEnabled = NO;
    _showPageIndicator = YES;
    _currentPage = 0;
    _realPage = 0;
    _prePage = -1;
    _scrollView = [self yzt_scrollView];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    _pageControl = [self yzt_pageControl];
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(5);
    }];
    
    [self yzt_addTapGesture];
}



- (UIPageControl *)yzt_pageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    return pageControl;
}

- (UIScrollView *)yzt_scrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    return scrollView;
}

- (void)yzt_addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yzt_tapPage)];
    [self addGestureRecognizer:tap];
}

- (void)yzt_autoScroll {
    NSInteger aimPage = self.currentPage + 1;
    if (self.cycleEnabled) {
        
    } else {
        if (aimPage >= self.pageNumber) {
            aimPage = 0;
        }
    }
    [self scrollToPage:aimPage animated:YES];
}

- (void)yzt_cacheItem:(PageViewItem *)item {
    NSMutableArray *tmpArr = self.reuseItems[item.reuseIdentifier];
    if (!tmpArr) {
        tmpArr = [@[] mutableCopy];
        self.reuseItems[item.reuseIdentifier] = tmpArr;
    }
    if (item) {
        [tmpArr addObject:item];
    }
}

- (void)yzt_tapPage {
    if ([self.delegate respondsToSelector:@selector(pageView:didSelectItemAtPage:)]) {
        [self.delegate pageView:self didSelectItemAtPage:self.currentPage];
    }
}

- (void)yzt_scrollLeft {
    NSInteger realPageNumber = self.pageNumber;
    if (self.cycleEnabled) {
        realPageNumber = self.pageNumber + 2;
        if (self.realPage > 0 && self.realPage < realPageNumber - 2) {
            NSInteger loadPage = self.realPage;
            PageViewItem *item = [self.usingItems lastObject];
            if (item) {
                [self yzt_cacheItem:item];
                [self.usingItems removeLastObject];
            }
            PageViewItem *newItem = nil;
            if (loadPage == 1) {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:self.pageNumber - 1];
            } else {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:loadPage - 2];
            }
            [self.scrollView addSubview:newItem];
            [self.usingItems insertObject:newItem atIndex:0];
            [newItem mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.height.mas_equalTo(self.scrollView);
                make.width.mas_equalTo(self.width);
                make.left.mas_equalTo(self.scrollView).offset(self.width * (loadPage - 1));
            }];
        }
    } else {
        if (self.realPage > 0 && self.realPage < realPageNumber - 2) {
            NSInteger loadPage = self.realPage - 1;
            PageViewItem *item = [self.usingItems lastObject];
            if (item) {
                [self yzt_cacheItem:item];
                [self.usingItems removeLastObject];
            }
            PageViewItem *newItem = [self.dataSource pageView:self itemForPageAtIndex:loadPage];
            [self.scrollView addSubview:newItem];
            [self.usingItems insertObject:newItem atIndex:0];
            [newItem mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.height.mas_equalTo(self.scrollView);
                make.width.mas_equalTo(self.width);
                make.left.mas_equalTo(self.scrollView).offset(self.width * loadPage);
            }];
        }
    }
    
}

- (void)yzt_scrollRight {
    NSInteger realPageNumber = self.pageNumber;
    if (self.cycleEnabled) {
        realPageNumber = self.pageNumber + 2;
        if (self.realPage > 1 && self.realPage < realPageNumber - 1) {
            NSInteger loadPage = self.realPage;
            PageViewItem *item = [self.usingItems firstObject];
            if (item) {
                [self yzt_cacheItem:item];
                [self.usingItems removeObjectAtIndex:0];
            }
            PageViewItem *newItem = nil;
            if (loadPage == self.pageNumber) {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:0];
            } else {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:loadPage];
            }
            [self.scrollView addSubview:newItem];
            [self.usingItems addObject:newItem];
            [newItem mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.height.mas_equalTo(self.scrollView);
                make.width.mas_equalTo(self.width);
                make.left.mas_equalTo(self.scrollView).offset(self.width * (loadPage + 1));
            }];
        }
    } else {
        if (self.realPage > 1 && self.realPage < realPageNumber - 1) {
            NSInteger loadPage = self.realPage + 1;
            PageViewItem *item = [self.usingItems firstObject];
            if (item) {
                [self yzt_cacheItem:item];
                [self.usingItems removeObjectAtIndex:0];
            }
            PageViewItem *newItem = [self.dataSource pageView:self itemForPageAtIndex:loadPage];
            
            [self.scrollView addSubview:newItem];
            [self.usingItems addObject:newItem];
            [newItem mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.height.mas_equalTo(self.scrollView);
                make.width.mas_equalTo(self.width);
                make.left.mas_equalTo(self.scrollView).offset(self.width * loadPage);
            }];
        }
    }
    
}

- (void)yzt_scrollToLeft {
    for (int i = 0; i < 3; i++) {
        PageViewItem *item = [self.usingItems firstObject];
        if (item) {
            [self yzt_cacheItem:item];
            [self.usingItems removeObjectAtIndex:0];
        }
        PageViewItem *newItem = nil;
        if (i == 0) {
            newItem = [self.dataSource pageView:self itemForPageAtIndex:self.pageNumber - 1];
        }
        if (i == 1) {
            newItem = [self.dataSource pageView:self itemForPageAtIndex:0];
        }
        if (i == 2) {
            if (self.pageNumber == 1) {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:0];
            } else {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:1];
            }
        }
        [self.scrollView addSubview:newItem];
        [self.usingItems addObject:newItem];
        [newItem mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.width);
            make.left.mas_equalTo(self.scrollView).offset(self.width * i);
        }];
    }
}

- (void)yzt_scrollToRight {
    NSInteger realPageNumber = self.pageNumber + 1;
    for (int i = 0; i < 3; i++) {
        PageViewItem *item = [self.usingItems lastObject];
        [self yzt_cacheItem:item];
        [self.usingItems removeLastObject];
        PageViewItem *newItem = nil;
        if (i == 0) {
            newItem = [self.dataSource pageView:self itemForPageAtIndex:0];
        }
        if (i == 1) {
            newItem = [self.dataSource pageView:self itemForPageAtIndex:self.pageNumber - 1];
        }
        if (i == 2) {
            if (self.pageNumber == 1) {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:0];
            } else {
                newItem = [self.dataSource pageView:self itemForPageAtIndex:self.pageNumber - 2];
            }
        }
        [self.scrollView addSubview:newItem];
        [self.usingItems insertObject:newItem atIndex:0];
        [newItem mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.width);
            make.left.mas_equalTo(self.scrollView).offset(self.width * (realPageNumber - i));
        }];
    }
}

- (void)yzt_loadData {
    if (!self.dataSource) {
        return;
    }
    if ([self.dataSource respondsToSelector:@selector(numberOfPagesInPageView:)]) {
        self.pageNumber = [self.dataSource numberOfPagesInPageView:self];
    }
    for (PageViewItem *item in self.usingItems) {
        [item removeFromSuperview];
    }
    [self.usingItems removeAllObjects];
    self.pageControl.numberOfPages = self.pageNumber;
    self.currentPage = 0;
    if (self.pageNumber <= 0) {
        return;
    }
    if (self.cycleEnabled) {
        self.scrollView.contentSize = CGSizeMake(self.width * (self.pageNumber + 2), self.height);
        PageViewItem *item1 = [self.dataSource pageView:self itemForPageAtIndex:self.pageNumber - 1];
        [self.scrollView addSubview:item1];
        [self.usingItems addObject:item1];
        [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.width);
        }];
        
        PageViewItem *item2 = [self.dataSource pageView:self itemForPageAtIndex:0];
        [self.scrollView addSubview:item2];
        [self.usingItems addObject:item2];
        [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.scrollView);
            make.left.mas_equalTo(self.scrollView).offset(self.width);
            make.width.mas_equalTo(self.width);
        }];
        
        PageViewItem *item3 = nil;
        if (self.pageNumber == 1) {
            item3 = [self.dataSource pageView:self itemForPageAtIndex:0];
        } else {
            item3 = [self.dataSource pageView:self itemForPageAtIndex:1];
        }
        [self.scrollView addSubview:item3];
        [self.usingItems addObject:item3];
        [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.scrollView);
            make.left.mas_equalTo(self.scrollView).offset(self.width * 2);
            make.width.mas_equalTo(self.width);
        }];
        
        [self.scrollView setContentOffset:CGPointMake(self.width, 0)];
    } else {
        self.scrollView.contentSize = CGSizeMake(self.width * self.pageNumber, self.height);
        PageViewItem *item1 = [self.dataSource pageView:self itemForPageAtIndex:0];
        [self.scrollView addSubview:item1];
        [self.usingItems addObject:item1];
        [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.width);
        }];
        if (self.pageNumber == 1) {
            return;
        }
        PageViewItem *item2 = [self.dataSource pageView:self itemForPageAtIndex:1];
        [self.scrollView addSubview:item2];
        [self.usingItems addObject:item2];
        [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.scrollView);
            make.left.mas_equalTo(self.scrollView).offset(self.width);
            make.width.mas_equalTo(self.width);
        }];
        if (self.pageNumber == 2) {
            return;
        }
        PageViewItem *item3 = [self.dataSource pageView:self itemForPageAtIndex:2];
        [self.scrollView addSubview:item3];
        [self.usingItems addObject:item3];
        [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.scrollView);
            make.left.mas_equalTo(self.scrollView).offset(self.width * 2);
            make.width.mas_equalTo(self.width);
        }];
    }
    
}


#pragma mark - scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = round(scrollView.contentOffset.x / self.width);
    self.realPage = page;
    if (self.realPage > self.prePage) {
        self.prePage = self.realPage;
        [self yzt_scrollRight];
    }
    if (self.realPage < self.prePage) {
        self.prePage = self.realPage;
        [self yzt_scrollLeft];
    }
    if (self.cycleEnabled) {
        if (scrollView.contentOffset.x >= (self.pageNumber + 1) * self.width) {
            scrollView.contentOffset = CGPointMake(self.width, 0);
            page = 0;
            [self yzt_scrollToLeft];
        } else if (scrollView.contentOffset.x <= 0) {
            scrollView.contentOffset = CGPointMake(self.width * self.pageNumber, 0);
            page = self.pageNumber - 1;
            [self yzt_scrollToRight];
        } else {
          page -= 1;
        }
    }
    self.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //重置定时器
    if (self.timer && self.timer.valid) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.autoScrollInterval]];
    }
    self.isDragging = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isDragging = YES;
    [self.timer yzt_pause];
}


#pragma mark - setter & getter

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    self.scrollView.scrollEnabled = scrollEnabled;
}

- (void)setAutoScrollEnabled:(BOOL)autoScrollEnabled {
    _autoScrollEnabled = autoScrollEnabled;
    if (autoScrollEnabled) {
        self.scrollEnabled = YES;
        if (!self.timer) {
            __weak typeof(self) weakSelf = self;
            self.timer = [NSTimer yzt_scheduledTimerWithTimeInterval:self.autoScrollInterval block:^{
                PageView *strongSelf = weakSelf;
                [strongSelf yzt_autoScroll];
            } repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [self.timer yzt_pause];
        }
    } else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (currentPage < 0 || currentPage >= self.pageNumber) {
        return;
    }
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        self.pageControl.currentPage = currentPage;
        if (self.isDragging || currentPage == self.aimPage) {
            if ([self.delegate respondsToSelector:@selector(pageView:didScrollToPage:)]) {
                [self.delegate pageView:self didScrollToPage:currentPage];
            }
        }
    }
}

- (void)setShowPageIndicator:(BOOL)showPageIndicator {
    _showPageIndicator = showPageIndicator;
    if (showPageIndicator) {
        self.pageControl.hidden = NO;
    } else {
        self.pageControl.hidden = YES;
    }
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (NSTimeInterval)autoScrollInterval {
    if (_autoScrollInterval <= 0) {
        return 5;
    }
    return _autoScrollInterval;
}

#pragma mark - public

- (void)reloadData {
    NSInteger page = self.currentPage;
    if (self.cycleEnabled) {
        self.scrollView.contentOffset = CGPointMake(self.width, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    [self yzt_loadData];
    [self scrollToPage:page animated:NO];
}

- (void)registerClass:(Class)itemClass forItemReuseIdentifier:(NSString *)identifier {
    if (identifier.length == 0 || !itemClass) {
        return;
    }
    self.registerItems[identifier] = itemClass;
}

- (PageViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
    NSMutableArray *tmpArr = self.reuseItems[identifier];
    PageViewItem *item = [tmpArr firstObject];
    if (item == nil) {
        Class itemClass = self.registerItems[identifier];
        item = (PageViewItem *)[[itemClass alloc] initWithResuseIndetifier:identifier];
    } else {
      [tmpArr removeObjectAtIndex:0];
    }
    return item;
}

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated {
    if (page == self.currentPage) {
        return;
    }
    NSInteger aimPage = page;
    self.aimPage = page;
    if (self.cycleEnabled) {
        aimPage = page + 1;
        if (page >= self.pageNumber + 1) {
            aimPage = self.pageNumber + 1;
        }
        if (page <= 0) {
            aimPage = 1;
        }
    } else {
        if (page >= self.pageNumber) {
            aimPage = self.pageNumber - 1;
        }
        if (page <= 0) {
            aimPage = 0;
        }
    }
    if (animated) {
        [self.scrollView setContentOffset:CGPointMake(self.width * aimPage, 0) animated:animated];
    } else {
        if (aimPage < self.realPage) {
            for (NSInteger i = self.realPage - 1; i >= aimPage; i--) {
                [self.scrollView setContentOffset:CGPointMake(self.width * i, 0) animated:animated];
            }
        } else {
            for (NSInteger i = self.realPage + 1; i <= aimPage; i++) {
                [self.scrollView setContentOffset:CGPointMake(self.width * i, 0) animated:animated];
            }
        }
    }
    
}

@end
