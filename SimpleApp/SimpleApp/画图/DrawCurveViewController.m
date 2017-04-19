//
//  DrawCurveViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/12.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "DrawCurveViewController.h"
#import <math.h>

@interface DrawCurveViewController ()

@end

@implementation DrawCurveViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self drawSineCurve];
}

#pragma mark - 绘制sine曲线

- (void)drawSineCurve {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 200, 300, 300);
    shapeLayer.backgroundColor = [UIColor purpleColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 100)];
    [path addQuadCurveToPoint:CGPointMake(100, 100) controlPoint:CGPointMake(50, 0)];
    [path addQuadCurveToPoint:CGPointMake(200, 100) controlPoint:CGPointMake(150, 200)];
    [path closePath];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 1;
    [shapeLayer setStrokeColor:[UIColor redColor].CGColor];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    [self.view.layer addSublayer:shapeLayer];
}

@end
