//
//  HealthChartViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/6/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HealthChartViewController.h"

#import "HealthChartView.h"

@interface HealthChartViewController ()<HealthChartDelegate>

@property (nonatomic, strong) HealthChartView *chart;

@end

@implementation HealthChartViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _chart = [[HealthChartView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth, 200)];
    _chart.delegate = self;
    _chart.yMaxValue = 250;
    _chart.yMinValue = 100;
    _chart.yScaleCount = 6;
    _chart.needContact = YES;
    
//    _chart.xTimingSource = @[@"6.16", @"6.15", @"6.14", @"6.10",
//                             @"6.9", @"6.8", @"6.7", @"6.6",
//                             @"6.4", @"6.3", @"6.2", @"6.1",
//                             @"5.28", @"5.25", @"5.24", @"5.22",
//                             @"5.18", @"5.15", @"5.14", @"5.12",
//                             @"5.8", @"5.5", @"5.4", @"5.2",
//                             ];
    _chart.xTimingSource = @[@"2017.6.19 18:00", @"2017.6.19 17:00", @"2017.6.19 16:00", @"2017.6.19 15:00",
                             @"2017.6.19 13:00", @"2017.6.19 12:00", @"2017.6.19 11:00", @"2017.6.19 10:00",
                             @"2017.6.19 9:00", @"2017.6.19 8:00", @"2017.6.19 3:00", @"2017.6.19 1:00",
                             @"2017.6.18 23:00", @"2017.6.18 20:00", @"2017.6.18 18:00", @"2017.6.18 15:00",
                             @"2017.6.18 13:00", @"2017.6.18 12:00", @"2017.6.18 11:00", @"2017.6.18 10:00",
                             @"2017.6.18 7:00", @"2017.6.18 6:00", @"2017.6.18 5:00", @"2017.6.18 2:00",
                             ];
    _chart.ySource = @[@138,@148,@158,@138,
                       @118,@178,@218,@208,
                       @158,@138,@118,@138,
                       @118,@178,@218,@208,
                       @158,@138,@118,@138,
                       @118,@178,@218,@208,
                       ];
    
    NSMutableArray *source = [NSMutableArray array];
    for (int i = 0; i < 14; i++) {
        NSMutableArray *temp = [NSMutableArray array];
        for (int j = 0; j < 4; j++) {
            NSString *value = nil;
            NSString *identify = [NSString stringWithFormat:@"%d", j % 2];
            if (j % 2 == 0) {
                value = [NSString stringWithFormat:@"%d", 40 + 15 * j];
            } else {
                value = [NSString stringWithFormat:@"%d", 120 + 15 * j];
            }
            
            [temp addObject:[[ChartItemModel alloc] initWithValue:value identify:identify]];
        }
        
        [source addObject:temp];
    }
    
//    _chart.yGroupSource = source;
    
    [self.view addSubview:_chart];
    
    _chart.yMaxValue = 57.5;
    _chart.yMinValue = 20.5;
    _chart.onlyShowMaxMin = YES;
    
    [_chart reloadData];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 200)];
    sc.backgroundColor = [UIColor yellowColor];
    sc.clipsToBounds = NO;
    [self.view addSubview:sc];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, 100, 100)];
    lb.backgroundColor = [UIColor purpleColor];
    [sc addSubview:lb];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - HealthChartDelegate

- (ChartUnitType)unitTypeForChart:(HealthChartView *)chart {
    return ChartUnitTypeDay;
}

- (NSInteger)numberOfXScale {
    return 7;
}

- (NSInteger)numberOfMinUnitInScale {
    return 4;
}

#pragma mark - event

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
