//
//  BloodRectPointView.h
//  SZYiZhangTong
//
//  Created by wuyp on 2017/2/22.
//  Copyright © 2017年 pingan. All rights reserved.
//

#import "BaseView.h"

/**
 图形类型:Day Week Month Year
 */
typedef NS_ENUM(NSInteger, ChartUnitType) {
    ChartUnitTypeDay,
    ChartUnitTypeWeek,
    ChartUnitTypeMonth,
    ChartUnitTypeYear
};

/**
 对于分组数组 需要连线时根据相同的identify进行连接
 */
@interface ChartItemModel : NSObject

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSString *identify;

- (instancetype)initWithValue:(NSString *)value identify:(NSString *)identify;

@end

@class HealthChartView;

@protocol HealthChartDelegate <NSObject>

@required

- (ChartUnitType)unitTypeForChart:(HealthChartView *)chart;

/**
 刻度数
 */
- (NSInteger)numberOfXScale;

/**
 两个刻度差值 代表多个最小单位
 */
- (NSInteger)numberOfMinUnitInScale;

@optional

/**
 定制数值View的样式
 
 @param view view
 @param col 列index
 @param row 对应列中对应的位置-->与数据源进行对应 当ySource时row=0;当设置yGroupSource时row对应item中的index
 @return view
 */
- (UIView *)healthChartView:(HealthChartView *)chart pointViewWithCol:(NSInteger)col row:(NSInteger)row;

@end

@interface HealthChartView : UIView

@property (nonatomic, weak) id<HealthChartDelegate> delegate;

/**
 最大值和最小值: 当max和min都为0时 取传入的最大值和最小值
 */
@property (nonatomic, assign) double yMaxValue;
@property (nonatomic, assign) double yMinValue;
@property (nonatomic, assign) NSInteger yScaleCount;

#pragma mark - display

@property (nonatomic, assign, getter=isNeedContact) BOOL needContact;

@property (nonatomic, assign) BOOL onlyShowMaxMin;

#pragma mark - source

@property (nonatomic, strong) NSArray<NSString *> *xTimingSource;

/**
 一个刻度只有一个点
 */
@property (nonatomic, strong) NSArray<NSString *> *ySource;

/**
 一个刻度具有多个点： 每个子数组之间可以连线
 */
@property (nonatomic, strong) NSArray<NSArray<ChartItemModel *> *> *yGroupSource;

- (void)reloadData;

@end
