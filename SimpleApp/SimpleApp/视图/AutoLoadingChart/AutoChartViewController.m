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
//    NSMutableArray *source = [NSMutableArray array];
//    for (int i = 0; i < 3; i++) {
//        AutoChartPageModel *model = [[AutoChartPageModel alloc] init];
//        model.xSource = @[@"1", @"2", @"3", @"4"];
//        model.ySource = @[@"10", @"20", @"30", @"45"];
//        [source addObject:model];
//    }
//    
//    self.chart.source = source;
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
