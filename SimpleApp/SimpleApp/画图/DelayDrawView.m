//
//  DelayDrawView.m
//  SimpleApp
//
//  Created by wuyp on 16/10/24.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "DelayDrawView.h"

@interface DelayDrawView()

@property (nonatomic, assign) BOOL isDraw;

@end

@implementation DelayDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)click:(UITapGestureRecognizer *)gesture {
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!_isDraw) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [[UIColor redColor] set];
    path.lineWidth = 2;
    
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
}

- (void)setupSource:(long long)cycleCount {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger sum = 0;
        for (long long i = 0; i < cycleCount; i++) {
            sum += i;
        }
       
        dispatch_async(dispatch_get_main_queue(), ^{
            _isDraw = YES;
            [self setNeedsDisplay];
        });
    });
}

@end
