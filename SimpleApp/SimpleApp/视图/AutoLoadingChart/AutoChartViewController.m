//
//  AutoChartViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "AutoChartViewController.h"

#import "AutoChart.h"
#import "AutoChartPageModel.h"

@interface AutoChartViewController ()

@property (nonatomic, strong) UIView *superView;

@property (nonatomic, strong) AutoChart *chart;

@end

@implementation AutoChartViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.superView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    _superView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_superView];
    
    self.chart = [[AutoChart alloc] initWithFrame:CGRectMake(0, 250, kScreenWidth, 200)];
    [self.view addSubview:_chart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSString *str1 = @"2010-01-01";
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date1 = [format dateFromString:str1];
    NSDateComponents *comp = [cal components:NSCalendarUnitYear fromDate:date1 toDate:[NSDate date] options:0];
    
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
