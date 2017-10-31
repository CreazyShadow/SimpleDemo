//
//  UIScrollView+EmptyPlaceHolder.h
//  SimpleCommon
//
//  Created by wuyp on 2017/10/31.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXEmptyDataSetSource <NSObject>

@optional

/**
 特殊页面可以定制，默认统一空视图
 */
- (UIView *)placeHolderViewForDataSet:(UIScrollView *)scrollView;

@end

@interface UIScrollView (EmptyDataSet)

@property (nonatomic, assign) BOOL canDisplayEmptyPlaceView; ///< 是否需要显示无数据视图，默认为NO

@property (nonatomic, weak) id<HXEmptyDataSetSource> emptyDataSource;

@end
