//
//  tailorView.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/27.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TailorView.h"

#import <QuartzCore/QuartzCore.h>

@interface TailorView()

@end

@implementation TailorView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self drawMaskByShaperLayer];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
}

#pragma mark - init sub views

- (void)initSubViews {
    
}

#pragma mark - event

#pragma mark - public

#pragma mark - private

- (void)drawMask {
    CGFloat height = self.height;
    CGFloat width = self.width;
    NSInteger count = 3;
    float yRange = 0.4;
    float maxY = 0.8;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, height)];
    for (int i = 0; i < count; i++) {
        [path addLineToPoint:CGPointMake(width / count * i, height * maxY)];
        [path addLineToPoint:CGPointMake((0.5 + i) * width / count, height * yRange)];
    }
    
    [path addLineToPoint:CGPointMake(width, height * maxY)];
    [path addLineToPoint:CGPointMake(width, height)];
    
    path.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [[UIColor orangeColor] setFill];
    
    [path closePath];
    
    [path stroke];
    [path fill];
}

- (void)drawMaskByShaperLayer {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1.f;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.height * 0.8)];
    [path addLineToPoint:CGPointMake(self.width * 0.5, self.height * 0.5)];
    [path addLineToPoint:CGPointMake(self.width, self.height * 0.8)];
    [path closePath];
    shapeLayer.path = path.CGPath;
    
//    [self.layer addSublayer:shapeLayer];
    self.layer.mask = shapeLayer;
    
}

#pragma mark - getter & setter

@end
