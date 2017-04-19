//
//  AutoChart.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutoChartPageModel.h"

@class AutoChart;

@protocol AutoChartDataSource <NSObject>

@required
- (NSArray<NSString *> *)autoChart:(AutoChart *)chart titlesForColumnInPage:(NSInteger)page;

/**
 每列对应的Y值

 @param chart 当前控件
 @param col X轴刻度：第几个列
 @param page 页码
 @return 对应的Y值
 */
- (id)autoChart:(AutoChart *)chart rowVauleForColumn:(NSInteger)col page:(NSInteger)page;

- (NSInteger)numberOfPagesInAutoChart;


@end

@interface AutoChart : UIView

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, weak) id<AutoChartDataSource> dataSource;

- (void)reloadData;

@end
