//
//  AutoChartPageItem.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "AutoChartPageView.h"

static CGFloat const kYTopBottomMargin = 15;
static CGFloat const kXScaleLineH = 5;
static CGFloat const kXScaleTextH = 20;

static CGFloat const kScaleLineWH = 1;

@interface AutoChartPageView()

@property (nonatomic, strong) NSMutableArray<CALayer *> *xScaleLineArray;
@property (nonatomic, strong) NSMutableArray<UILabel *> *xScaleTextArray;

@property (nonatomic, strong) NSMutableArray<CALayer *> *yScaleLineArray;

@property (nonatomic, strong) NSMutableArray<UIView  *> *yPointArray;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UIView *> *> *yGroupPointArray;

@end

@implementation AutoChartPageView
{
    NSInteger _yScaleCount;
    CGFloat _maxValue;
    CGFloat _minValue;
}

#pragma mark - life cycle

- (instancetype)initWithYScaleCount:(NSInteger)yScaleCount {
    if (self = [super init]) {
        NSParameterAssert(yScaleCount);
        _yScaleCount = yScaleCount;
    }
    
    return self;
}

- (instancetype)initWithYScaleCount:(NSInteger)yScaleCount frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSParameterAssert(yScaleCount);
        _yScaleCount = yScaleCount;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_pageModel || _pageModel.xSource.count == 0 || _pageModel.ySource.count == 0 || _yScaleCount == 0) {
        return;
    }
    
    CGFloat xScaleValue = self.width / _pageModel.xSource.count;
    CGFloat yScaleValue = (self.height - 2 * kYTopBottomMargin - kXScaleLineH - kXScaleTextH) / (_maxValue - _minValue);
    
    CGFloat yScaleLineDistance = (self.height - 2 * kYTopBottomMargin - kXScaleLineH - kXScaleTextH) / _yScaleCount;
    //y刻度线: 由于不显示最上面一根刻度线 (5段==6条刻度线)
    for (int i = 0; i < _yScaleLineArray.count; i++) {
        CALayer *yScale = _yScaleLineArray[i];
        yScale.frame = CGRectMake(0, kYTopBottomMargin + (i + 1) * yScaleLineDistance, self.width, kScaleLineWH);
    }
    
    CGFloat yScaleLineMaxY = CGRectGetMaxY(_yScaleLineArray.lastObject.frame);
    //x刻度线
    for (int i = 0; i < _xScaleLineArray.count; i++) {
        CALayer *xScale = _xScaleLineArray[i];
        xScale.frame = CGRectMake(xScaleValue * i - 0.5 * kScaleLineWH, yScaleLineMaxY, kScaleLineWH, kXScaleLineH);
    }
    
    //x文本
    for (int i = 0; i < _xScaleTextArray.count; i++) {
        UILabel *temp = _xScaleTextArray[i];
        temp.frame = CGRectMake(xScaleValue * i - 0.5 * xScaleValue, yScaleLineMaxY, xScaleValue, kXScaleTextH);
    }

    //画点
    for (int i = 0; i < _yPointArray.count; i++) {
        UIView *point = _yPointArray[i];
        CGFloat current = _pageModel.ySource[i].floatValue;
        point.size = CGSizeMake(10, 10);
        point.center = CGPointMake(xScaleValue * i, kYTopBottomMargin + (_maxValue - current) * yScaleValue);
        point.layer.cornerRadius = 5;
        point.backgroundColor = [UIColor orangeColor];
    }
    
    //连线
    CAShapeLayer *lineShaperLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < _yPointArray.count; i++) {
        if (i == 0) {
            [path moveToPoint:_yPointArray[i].center];
        } else {
            [path addLineToPoint:_yPointArray[i].center];
        }
    }
    
    lineShaperLayer.lineWidth = 1;
    lineShaperLayer.path = path.CGPath;
    [lineShaperLayer setStrokeColor:[UIColor redColor].CGColor];
    [lineShaperLayer setFillColor:[UIColor clearColor].CGColor];
//    [self.layer addSublayer:lineShaperLayer];
    [self.layer insertSublayer:lineShaperLayer atIndex:0];
}

#pragma mark - event

#pragma mark - public

#pragma mark - private

- (void)drawXScale:(NSArray<NSString *> *)source {
    for (NSString *item in source) {
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:line];
        [_xScaleLineArray addObject:line];
        
        UILabel *xText = [[UILabel alloc] init];
        xText.text = item;
        xText.textColor = [UIColor redColor];
        xText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:xText];
        [_xScaleTextArray addObject:xText];
    }
}

- (void)drawYScaleLine {
    for (int i = 0; i < _yScaleCount; i++) {
        CALayer *yLine = [CALayer layer];
        yLine.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:yLine];
        [_yScaleLineArray addObject:yLine];
    }
}

- (void)drawYPoint:(NSArray *)source {
    BOOL isGroup = NO;
    if (source.count > 0 && [source.firstObject isKindOfClass:[NSArray class]]) {
        isGroup = YES;
    }

    _maxValue = 0;
    _minValue = CGFLOAT_MAX;
    for (int i = 0; i < source.count; i++) {
        
        if (isGroup) {
            NSMutableArray *yGroup = [NSMutableArray array];
            NSArray *temp = source[i];
            for (int j = 0; i < temp.count; j++) {
                UIView *point = [[UIView alloc] init];
                [self addSubview:point];
                [yGroup addObject:point];
                
                CGFloat curr = [temp[j] floatValue];
                if (_maxValue < curr) {
                    _maxValue = curr;
                }
                
                if (_minValue > curr) {
                    _minValue = curr;
                }
            }
            
            [_yGroupPointArray addObject:yGroup];
        } else {
            UIView *point = [[UIView alloc] init];
            [self addSubview:point];
            [_yPointArray addObject:point];
            
            CGFloat curr = [source[i] floatValue];
            if (_maxValue < curr) {
                _maxValue = curr;
            }
            
            if (_minValue > curr) {
                _minValue = curr;
            }
        }
    }
}

- (void)clearSubViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark - getter & setter

- (void)setPageModel:(AutoChartPageModel *)pageModel {
    _pageModel = pageModel;
    
    if (!pageModel || pageModel.xSource.count == 0 || pageModel.ySource.count == 0 || _yScaleCount == 0) {
        return;
    }
    
    _xScaleLineArray = [NSMutableArray arrayWithCapacity:pageModel.xSource.count];
    _xScaleTextArray = [NSMutableArray arrayWithCapacity:pageModel.xSource.count];
    _yScaleLineArray = [NSMutableArray arrayWithCapacity:_yScaleCount];
    _yPointArray     = [NSMutableArray arrayWithCapacity:pageModel.ySource.count];
    _yGroupPointArray= [NSMutableArray arrayWithCapacity:pageModel.ySource.count];
    
    [self drawXScale:pageModel.xSource];
    [self drawYScaleLine];
    [self drawYPoint:pageModel.ySource];
    
    [self setNeedsLayout];
}

@end
