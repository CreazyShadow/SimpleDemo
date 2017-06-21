//
//  DrawViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/10/24.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "DrawViewController.h"
#import "DelayDrawView.h"

#import "tailorView.h"

@interface DrawViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DelayDrawView *delayView;

@property (nonatomic, strong) TailorView *tailorView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TailorView *tailor = [[TailorView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 200)];
//    tailor.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:tailor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self drawManyLine];
}

#pragma mark - delay draw path

- (void)delayDrawPath:(UIColor *)color {
    DelayDrawView *view = [[DelayDrawView alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
    view.backgroundColor = color;
    [self.view addSubview:view];
    self.delayView = view;
}

#pragma mark - 多条线

- (void)drawManyLine {

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    layer.frame = CGRectMake(0, 50, 375, 300);
    [self.view.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 150)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(200, 180)];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(20, 80)];
    [path1 addLineToPoint:CGPointMake(60, 100)];
    [path1 addLineToPoint:CGPointMake(150, 150)];
    
//    [path appendPath:path1];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 appendPath:path];
    [path2 appendPath:path1];
    
    [layer setStrokeColor:[UIColor redColor].CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    layer.lineWidth = 2;
    
    layer.path = path2.CGPath;
}

@end
