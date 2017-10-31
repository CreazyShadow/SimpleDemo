//
//  UIScrollView+EmptyPlaceHolder.m
//  SimpleCommon
//
//  Created by wuyp on 2017/10/31.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "UIScrollView+EmptyDataSet.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "NSObject+Runtime.h"

static void *kCanDisplayEmptyPlaceViewKey   = &kCanDisplayEmptyPlaceViewKey;
static void *kEmptyDataSetSourceDelegateKey = &kEmptyDataSetSourceDelegateKey;
static void *kEmptyPlaceViewKey             = &kEmptyPlaceViewKey;

@implementation UIScrollView (EmptyDataSet)

#pragma mark - swizzle method

- (void)exchangeReloadDataMethod {
    static BOOL hasExchange = NO; // 只交换一次
    if (hasExchange) {
        return;
    }
    
    hasExchange = YES;

    Class cls = [self class];
    [cls swizzleInstanceMethodWithOriginSel:@selector(reloadData) swizzledSel:@selector(empty_reloadData)];
    
    if ([cls isKindOfClass:[UITableView class]]) {
        [UIScrollView swizzleInstanceMethodWithOriginSel:@selector(endUpdates) swizzledSel:@selector(empty_endUpdates)];
    }
}

- (void)empty_reloadData {
    [self empty_reloadData];
    [self displayEmptyPlaceView];
}

- (void)empty_endUpdates {
    [self empty_endUpdates];
    [self displayEmptyPlaceView];
}

#pragma mark - private

/**
 判断是否需要显示Empty View
 */
- (BOOL)needDisplayEmptyPlaceHolder {
    NSInteger items = 0;
    
    //scrollview
    if (![self respondsToSelector:@selector(reloadData)]) {
        return items;
    }
    
    //tableview
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)self;
        id<UITableViewDataSource> dataSource = tableview.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableview];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableview numberOfRowsInSection:section];
            }
        }
        
        //collectionview
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        id<UICollectionViewDataSource> dataSource = collectionView.dataSource;
       
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}

- (void)displayEmptyPlaceView {
    //先移除前一个View 防止empty view不同从而造成页面存在多个占位图
    [self hidenOrDisplayEmptyPlaceHolderView:NO];
    
    if (!self.canDisplayEmptyPlaceView || [self needDisplayEmptyPlaceHolder]) {
        return;
    }
    
    UIView *emptyPlaceHolder = nil;
    if (self.emptyDataSource && [self.emptyDataSource respondsToSelector:@selector(placeHolderViewForDataSet:)]) {
        emptyPlaceHolder = [self.emptyDataSource placeHolderViewForDataSet:self];
    } else {
        //公共View
        
    }
    
    objc_setAssociatedObject(self, kEmptyPlaceViewKey, emptyPlaceHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //display
    [self hidenOrDisplayEmptyPlaceHolderView:YES];
}

- (void)hidenOrDisplayEmptyPlaceHolderView:(BOOL)display {
    UIView *place = objc_getAssociatedObject(self, kEmptyPlaceViewKey);
    if (![place isKindOfClass:[UIView class]]) {
        return;
    }
    
    //移除
    if (!display) {
        [place removeFromSuperview];
        return;
    }
    
    //不在当前视图上
    if (![place.superview isEqual:self]) {
        CGFloat offsetY = fabs(self.contentOffset.y);
        place.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - offsetY);
        [self addSubview:place];
    }
}

#pragma mark - getter & setter

- (BOOL)canDisplayEmptyPlaceView {
    return [objc_getAssociatedObject(self, kCanDisplayEmptyPlaceViewKey) boolValue];
}

- (void)setCanDisplayEmptyPlaceView:(BOOL)canDisplayEmptyPlaceView {
    [self exchangeReloadDataMethod];
    
    NSNumber *value = [NSNumber numberWithBool:canDisplayEmptyPlaceView];
    objc_setAssociatedObject(self, kCanDisplayEmptyPlaceViewKey, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id<HXEmptyDataSetSource>)emptyDataSource {
    return objc_getAssociatedObject(self, kEmptyDataSetSourceDelegateKey);
}

- (void)setEmptyDataSource:(id<HXEmptyDataSetSource>)emptyDataSource {
    objc_setAssociatedObject(self, kEmptyDataSetSourceDelegateKey, emptyDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
