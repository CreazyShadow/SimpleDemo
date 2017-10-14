//
//  BloodRectPointView.m
//  SZYiZhangTong
//
//  Created by wuyp on 2017/2/22.
//  Copyright © 2017年 pingan. All rights reserved.
//

#import "HealthChartView.h"

#import "UIView+Identify.h"

static CGFloat const xScaleSliceTextMargin = 2;     ///< x轴刻度跨日或者月文本距离
static CGFloat const xScaleTextMargin = 17;         ///< x轴刻度线与水平刻度线距离
static CGFloat const kLeftRightMargin = 20;         ///< 两边距离
static CGFloat const kXScaleTextViewHeight = 40;    ///< x轴刻度视图高度
static CGFloat const kPageNum = 2;                  ///< page数量

#define CMScale(size) size

@interface HealthChartView()

@property (nonatomic, strong) NSMutableArray<CALayer *> *xScaleLines; ///< X轴刻度线
@property (nonatomic, strong) NSMutableArray<CALayer *> *yScaleLines; ///< Y轴刻度线

@property (nonatomic, strong) NSMutableArray<UILabel *> *xScaleSliceTexts;  ///< 跨月或者跨日文本 自动创建添加
@property (nonatomic, strong) NSMutableArray<UILabel *> *xScaleTexts;       ///< X轴刻度文本控件
@property (nonatomic, strong) NSMutableArray<NSString *>*xScaleTextDataArray;///<x轴刻度文本值数组

@property (nonatomic, strong) NSMutableArray<UIView *>  *valuePoints; ///< 数据点集合
@property (nonatomic, strong) NSMutableArray<NSArray<UIView *> *>  *groupValuePoints; ///< 数据点集合

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) NSMutableArray<UILabel *> *yValueLbls; ///< y值刻度Label

@end

@implementation HealthChartView

#pragma mark - init

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    _containerScrollView = [[UIScrollView alloc] init];
    _containerScrollView.backgroundColor = [UIColor grayColor];
    [self addSubview:_containerScrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger xScaleNum = [self scaleCount];
    
    if (self.yScaleCount == 0 || xScaleNum == 0) {
        return;
    }
    
    if (self.ySource.count == 0 && self.yGroupSource.count == 0) {
        return;
    }
    
    _containerScrollView.frame = self.bounds;
    _containerScrollView.y = 5;
    _containerScrollView.height -= 5;
    _containerScrollView.contentSize = CGSizeMake(kPageNum * kScreenWidth, 0);
    _containerScrollView.contentOffset = CGPointMake((kPageNum - 1) * kScreenWidth, 0);
    
    //计算x轴刻度线刻度值和y刻度值
    CGFloat chartHeight = self.height - kXScaleTextViewHeight - 5;
    
    CGFloat xScaleWidth = (kScreenWidth - kLeftRightMargin) / ((xScaleNum * 0.5 - 1) + 0.5);
    CGFloat yScaleHeight = chartHeight / ((self.yScaleCount - 1) ?: 1);
    
    //x轴刻度线
    for (int i = 0; i < _xScaleLines.count; i++) {
        CALayer *temp = _xScaleLines[i];
        temp.frame = CGRectMake(kPageNum * kScreenWidth - kLeftRightMargin - i * xScaleWidth, 0, 1, chartHeight);
    }
    
    //x轴刻度文本和 跨度文本
    int j = 0;
    for (int i = 0; i < _xScaleTexts.count && i < _xScaleTextDataArray.count; i++) {
        UILabel *temp = _xScaleTexts[i];
        temp.size = CGSizeMake(xScaleWidth, CMScale(12));
        temp.y = chartHeight + CMScale(xScaleTextMargin);
        temp.centerX = kPageNum * kScreenWidth - i * xScaleWidth - CMScale(kLeftRightMargin);
        
        if ([_xScaleTextDataArray[i] containsString:@"|"]) {
            UILabel *slice = _xScaleSliceTexts[j++];
            slice.backgroundColor = [UIColor redColor];
            slice.size = CGSizeMake(xScaleWidth, CMScale(10));
            slice.centerX = temp.centerX;
            slice.y = chartHeight + CMScale(xScaleSliceTextMargin);
        }
    }
    
    //y轴刻度线
    for (int i = 0; i < _yScaleLines.count && i < _yValueLbls.count; i++) {
        CALayer *temp = _yScaleLines[i];
        temp.frame = CGRectMake(0, i * yScaleHeight, kPageNum * kScreenWidth, 1);
        
        _yValueLbls[i].text = [NSString stringWithFormat:@"%d", i];
        _yValueLbls[i].y = i * yScaleHeight + 10;
        if (i == _yScaleLines.count - 1 && _onlyShowMaxMin && i >= 1) {
            _yValueLbls[i - 1].y = i * yScaleHeight + 5 - 3 - _yValueLbls[i].height;
        }
    }
    
    //数据值
    CGFloat yScaleAvgValue = chartHeight / ((self.yMaxValue - self.yMinValue) ?: 1);
    for (int i = 0; i < _valuePoints.count && i < self.ySource.count; i++) {
        UIView *temp = _valuePoints[i];
        
        NSInteger distance = [self minUnitCountFromStartDate:@"2017.06.19" destDate:self.xTimingSource[i]];
        NSInteger scaleCount = [self.delegate numberOfMinUnitInScale];
        temp.center = CGPointMake(kPageNum * kScreenWidth - CMScale(kLeftRightMargin) - distance * (xScaleWidth / scaleCount), (_yMaxValue - self.ySource[i].floatValue) * yScaleAvgValue);
    }
    
    for (int i = 0; i < _groupValuePoints.count && i < self.yGroupSource.count; i++) {
        NSArray *groupView = _groupValuePoints[i];
        NSArray<ChartItemModel *> *groupSource = self.yGroupSource[i];
        
        for (int j = 0; j < groupView.count && j < groupSource.count; j++) {
            UIView *temp = groupView[j];
            NSInteger distance = [self minUnitCountFromStartDate:@"2017.06.16" destDate:self.xTimingSource[i]];
            NSInteger scaleCount = [self.delegate numberOfMinUnitInScale];
            temp.center = CGPointMake(kPageNum * kScreenWidth - CMScale(kLeftRightMargin) - distance * (xScaleWidth / scaleCount), (_yMaxValue - [groupSource[j].value floatValue]) * yScaleAvgValue);
        }
    }
    
    //连线
    [self contactPoints];
}

- (NSInteger)minUnitCountFromStartDate:(NSString *)startDate destDate:(NSString *)destDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy.MM.dd";
    NSDate *start = [dateFormat dateFromString:startDate];
    if ([self.delegate unitTypeForChart:self] == ChartUnitTypeDay) {
        dateFormat.dateFormat = @"yyyy.MM.dd HH:ss";
        start = [start dateByAddingTimeInterval:24 * 60 * 60];
    }
    
    NSDate *dest = [dateFormat dateFromString:destDate];
    NSTimeInterval interval = [start timeIntervalSinceDate:dest];
    switch ([self.delegate unitTypeForChart:self]) {
        case ChartUnitTypeDay:
            return interval / (60 * 60);
            
        case ChartUnitTypeWeek:
        case ChartUnitTypeMonth:
            return interval / (60 * 60 * 24);
            
        case ChartUnitTypeYear:
        {
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:dest toDate:start options:0];
            return components.month;
        }
    }
}

#pragma mark - public

- (void)reloadData {
    [self resetSource];
    
    [self createYScaleLines];
    [self createXScaleLineAndRectAndText];
    [self createSinglePoint];
    
    [self setNeedsLayout];
}

#pragma mark - private

- (void)resetSource {
    [_xScaleLines removeAllObjects];
    [_yScaleLines removeAllObjects];
    
    [_xScaleSliceTexts removeAllObjects];
    [_xScaleTexts removeAllObjects];
    
    [_valuePoints removeAllObjects];
    [_groupValuePoints removeAllObjects];
    
    [self.containerScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.containerScrollView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)createYScaleLines {
    _yScaleLines = [NSMutableArray arrayWithCapacity:_yScaleCount];
    _yValueLbls = [NSMutableArray arrayWithCapacity:_yScaleCount];
    for (int i = 0; i < _yScaleCount; i++) {
        CALayer *temp = [CALayer layer];
        //        temp.backgroundColor = [UIColor colorWithHexString:@"#f3f0f0"].CGColor;
        temp.backgroundColor = [UIColor redColor].CGColor;
        temp.zPosition = 1;
        [_containerScrollView.layer addSublayer:temp];
        [_yScaleLines addObject:temp];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - CMScale(kLeftRightMargin + 5) - 100, 0, 100, CMScale(12))];
        lbl.textColor = [UIColor redColor];
        lbl.textAlignment = NSTextAlignmentRight;
        [self addSubview:lbl];
        [_yValueLbls addObject:lbl];
        
        if (_onlyShowMaxMin && i > 0 && i < _yScaleCount - 2) {
            lbl.hidden = YES;
        }
    }
    
    _yValueLbls.lastObject.hidden = YES;
}

- (void)createXScaleLineAndRectAndText {
    
    _xScaleLines = [[NSMutableArray alloc] init];
    _xScaleTexts = [[NSMutableArray alloc] init];
    _xScaleSliceTexts = [[NSMutableArray alloc] init];
    
    NSInteger xScaleNum = [self scaleCount];
    
    [self setupXScaleTextDateSourceByScaleNumberAndUnit];
    
    for (int i = 0; i < xScaleNum && i < _xScaleTextDataArray.count; i++) {
        //X轴刻度线
        CALayer *line = [CALayer layer];
        line.zPosition = 1;
        //        line.backgroundColor = [UIColor colorWithHexString:@"#f3f0f0"].CGColor;
        line.backgroundColor = [UIColor purpleColor].CGColor;
        [_containerScrollView.layer addSublayer:line];
        [_xScaleLines addObject:line];
        
        //X轴文本
        UILabel *text = [[UILabel alloc] init];
        //        text.textColor = TextColorA9F;
        //        text.font = CFourthFont;
        NSString *temp = _xScaleTextDataArray[i];
        NSRange range = [temp rangeOfString:@"|"];
        if (range.location != NSNotFound) {
            UILabel *sliceLbl = [[UILabel alloc] init];
            sliceLbl.font = [UIFont systemFontOfSize:10];
            sliceLbl.textAlignment = NSTextAlignmentCenter;
            sliceLbl.text = [temp substringToIndex:range.location];
            //            sliceLbl.textColor = TextColorA9F;
            //            sliceLbl.font = CFourthFont;
            [_xScaleSliceTexts addObject:sliceLbl];
            [_containerScrollView addSubview:sliceLbl];
            
            text.text = [temp substringFromIndex:range.location + range.length];
        } else {
            if ([self.delegate unitTypeForChart:self] == ChartUnitTypeDay && temp.intValue % 12 != 0) {
                temp = nil;
            }
            
            text.text = temp;
        }
        
        text.backgroundColor = [UIColor greenColor];
        text.textAlignment = NSTextAlignmentCenter;
        [_containerScrollView addSubview:text];
        [_xScaleTexts addObject:text];
    }
}

- (void)createSinglePoint {
    if (self.ySource.count > 0) {
        _valuePoints = [NSMutableArray arrayWithCapacity:self.ySource.count];
        for (int i = 0; i < self.ySource.count; i++) {
            UIView *point = [self pointWithColumn:i row:0 chart:self];
            point.layer.zPosition = 13;
            [_containerScrollView addSubview:point];
            [_valuePoints addObject:point];
        }
    } else if (self.yGroupSource.count > 0 && self.yGroupSource[0].count > 0) {
        _groupValuePoints = [NSMutableArray arrayWithCapacity:self.yGroupSource.count];
        
        for (int i = 0; i < self.yGroupSource.count; i++) {
            NSArray<ChartItemModel *> *col = self.yGroupSource[i];
            NSMutableArray *temp = [NSMutableArray arrayWithCapacity:col.count];
            for (int j = 0; j < col.count; j++) {
                UIView *point = [self pointWithColumn:i row:j chart:self];
                point.layer.zPosition = 13;
                point.identify = col[j].identify;
                [_containerScrollView addSubview:point];
                [temp addObject:point];
            }
            
            [_groupValuePoints addObject:temp];
        }
    }
}

- (UIView *)pointWithColumn:(NSInteger)col row:(NSInteger)row chart:(HealthChartView *)chart {
    if ([self.delegate respondsToSelector:@selector(healthChartView:pointViewWithCol:row:)]) {
        return [self.delegate healthChartView:self pointViewWithCol:col row:row];
    }
    
    UIView *point = [[UIView alloc] init];
    point.size = CGSizeMake(10, 10);
    point.layer.cornerRadius = 5;
    point.backgroundColor = [UIColor whiteColor];
    point.layer.borderColor = [UIColor blueColor].CGColor;
    point.layer.borderWidth = 2;
    
    return point;
}

- (void)contactPoints {
    if (self.needContact) {
        
        if (_valuePoints.count > 1) {
            [self contactSinglePoint];
        } else if(_groupValuePoints.count > 1) {
            [self contactEqualXScalePoint];
        }
    }
}

/**
 连接不同刻度的点并且绘制阴影
 */
- (void)contactSinglePoint {
    if (_valuePoints.count == 1) {
        return;
    }
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    
    backgroundLayer.zPosition = 10;
    lineLayer.zPosition = 11;
    [_containerScrollView.layer addSublayer:backgroundLayer];
    [_containerScrollView.layer addSublayer:lineLayer];
    
    UIBezierPath *backgroundPath = [UIBezierPath bezierPath];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < _valuePoints.count; i++) {
        UIView *point = _valuePoints[i];
        if (i == 0) {
            [backgroundPath moveToPoint:CGPointMake(point.centerX, _containerScrollView.height - kXScaleTextViewHeight)];
            [linePath moveToPoint:point.center];
        }
        
        [backgroundPath addLineToPoint:point.center];
        [linePath addLineToPoint:point.center];
        
        if (i == _valuePoints.count - 1) {
            [backgroundPath addLineToPoint:CGPointMake(point.centerX, _containerScrollView.height - kXScaleTextViewHeight)];
        }
    }
    
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = 2;
    [lineLayer setStrokeColor:[UIColor redColor].CGColor];
    [lineLayer setFillColor:[UIColor clearColor].CGColor];
    
    backgroundLayer.path = backgroundPath.CGPath;
    [backgroundLayer setFillColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor];
}

/**
 垂直方向连接groupsource的点
 */
- (void)contactEqualXScalePoint {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.zPosition = 10;
    [self.containerScrollView.layer addSublayer:layer];
    
    UIBezierPath *totalPath = [UIBezierPath bezierPath];
    for (int i = 0; i < _groupValuePoints.count; i++) {
        NSArray<UIView *> *item = _groupValuePoints[i];
        
        NSMutableDictionary<NSString *, UIBezierPath *> *temp = [NSMutableDictionary dictionary];
        for (UIView *point in item) {
            UIBezierPath *path = temp[point.identify];
            if (path) {
                [path addLineToPoint:point.center];
            } else {
                path = [UIBezierPath bezierPath];
                [temp setObject:path forKey:point.identify];
                [path moveToPoint:point.center];
            }
        }
        
        [temp.allValues enumerateObjectsUsingBlock:^(UIBezierPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [totalPath appendPath:obj];
        }];
    }
    
    layer.path = totalPath.CGPath;
}

#pragma mark - 处理x轴刻度值

- (void)setupXScaleTextDateSourceByScaleNumberAndUnit {
    NSInteger num = [self scaleCount];
    ChartUnitType type = [self.delegate unitTypeForChart:self];
    NSInteger scale = [self.delegate numberOfMinUnitInScale];
    
    self.xScaleTextDataArray = [NSMutableArray array];
    
    NSArray *old = nil;//日期跨度 月份 年份 天
    for (int i = 0; i < num; i++) {
        NSArray *arr = [self componentWithUnit:type scaleNum:scale index:i];
        //当最小单位不为Hour时
        if (old.count > 0 && ![old[0] isEqualToString:arr[0]]) {
            _xScaleTextDataArray[i - 1] = [NSString stringWithFormat:@"%@|%@", old[0], old[1]];
        }
        
        [_xScaleTextDataArray addObject:[NSString stringWithFormat:@"%@", arr[1]]];
        
        //当最小单位为Hour时
//        if (type == ChartUnitTypeDay && old.count > 0 && ![old[0] isEqualToString:arr[0]]) {
//            _xScaleTextDataArray[i] = [NSString stringWithFormat:@"%@|%@", arr[0], arr[1]];
//        }
        
        old = arr;
    }
}

- (NSArray<NSString *> *)componentWithUnit:(ChartUnitType)type scaleNum:(NSInteger)num index:(NSInteger)index {
    NSCalendar *current = [NSCalendar currentCalendar];
    NSMutableArray *scaleValue = [NSMutableArray array];
    
    NSString *tip = nil;
    NSString *value = nil;
    switch (type) {
        case ChartUnitTypeDay:
        {
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            dateFormat.dateFormat = @"yyyyMMdd";
            NSString *old = [dateFormat stringFromDate:date];
            NSDate *currentMaxDate = [[dateFormat dateFromString:old] dateByAddingTimeInterval:24 * 60 * 60];
            dateFormat.dateFormat = @"MM月dd日";
            if (index == 0) {
                tip = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]];
                value = [NSString stringWithFormat:@"%d:00", 24];
                break;
            }
            
            NSDate *now = [currentMaxDate dateByAddingTimeInterval:index * num * -3600];
            tip = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:now]];
            value = [NSString stringWithFormat:@"%ld:00", 24 - (index * num % 24 ?: 24)];
        }
            break;
            
        case ChartUnitTypeWeek:
        case ChartUnitTypeMonth:
        {
            NSDate *date = [current dateByAddingUnit:NSCalendarUnitDay value:-(index * num) toDate:[NSDate date] options:0];
            tip = [NSString stringWithFormat:@"%ld月", [current component:NSCalendarUnitMonth fromDate:date]];
            value = [NSString stringWithFormat:@"%ld", [current component:NSCalendarUnitDay fromDate:date]];
        }
            break;
            
        case ChartUnitTypeYear:
        {
            NSDate *date = [current dateByAddingUnit:NSCalendarUnitMonth value:-(index * num) toDate:[NSDate date] options:0];
            tip = [NSString stringWithFormat:@"%ld年", [current component:NSCalendarUnitYear fromDate:date]];
            value = [NSString stringWithFormat:@"%ld", [current component:NSCalendarUnitMonth fromDate:date]];
        }
            break;
    }
    
    [scaleValue addObject:tip];
    [scaleValue addObject:value];
    return [scaleValue copy];
}

#pragma mark - 代理方法

- (NSInteger)scaleCount {
    NSInteger num = kPageNum * [self.delegate numberOfXScale];
    return [self.delegate unitTypeForChart:self] == ChartUnitTypeDay ? num - 1 : num;
}

#pragma mark - getter & setter

- (BOOL)isNeedContact {
    return _needContact;
}

@end

#pragma mark - model

@implementation ChartItemModel

- (instancetype)initWithValue:(NSString *)value identify:(NSString *)identify {
    if (self = [super init]) {
        self.value = value;
        self.identify = identify;
    }
    
    return self;
}

@end
