//
//  RecycleScrollView.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecycleScrollView;
@class RecyleScrollViewItem;

@protocol RecycleScrollViewDataSource <NSObject>

@required

- (NSInteger)numberOfPagesInRecyleScrollView;

- (RecyleScrollViewItem *)recycleScrollView:(RecycleScrollView *)scrollview itemForPage:(NSInteger)page;

- (Class)itemClassInRecycleScrollView;

- (void)renderingItem:(RecyleScrollViewItem *)item forPage:(NSInteger)page;

@end

@interface RecycleScrollView : UIView

@property (nonatomic, weak) id<RecycleScrollViewDataSource> dataSource;

//- (void)registClass:(Class)itemClass forItemIdentify:(NSString *)identify;
//
//- (RecyleScrollViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identify;

- (void)reloadData;

@end
