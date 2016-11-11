//
//  YZTPageView.h
//  popDemo
//
//  Created by chenlehui on 16/4/25.
//  Copyright © 2016年 chenlehui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewItem.h"

@class PageView;

@protocol PageViewDataSource <NSObject>

- (NSInteger)numberOfPagesInPageView:(PageView *)pageView;

- (PageViewItem *)pageView:(PageView *)pageView itemForPageAtIndex:(NSInteger)index;

@end

@protocol PageViewDelegate <NSObject>

@optional
- (void)pageView:(PageView *)pageView didSelectItemAtPage:(NSInteger)page;

- (void)pageView:(PageView *)pageView didScrollToPage:(NSInteger)page;

@end

@interface PageView : UIView

@property (nonatomic, assign) BOOL scrollEnabled; // default "YES"

@property (nonatomic, assign) BOOL autoScrollEnabled; // default "NO"

@property (nonatomic, assign) BOOL cycleEnabled; // default "NO"

@property (nonatomic, assign) BOOL showPageIndicator; // default "YES"

@property (nonatomic, assign) NSTimeInterval autoScrollInterval; // default "5s"

@property (nonatomic, weak) id <PageViewDataSource> dataSource;

@property (nonatomic, weak) id <PageViewDelegate> delegate;

@property (nonatomic, assign, readonly) NSInteger currentPage;

- (void)reloadData;

- (void)registerClass:(Class)itemClass forItemReuseIdentifier:(NSString *)identifier;

- (PageViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier;

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;

@end
