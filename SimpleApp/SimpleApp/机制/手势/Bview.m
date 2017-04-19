//
//  Bview.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/31.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Bview.h"

@interface Bview()

@end

@implementation Bview

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

#pragma mark - init sub views

- (void)initSubViews {
    
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"-----B---touched");
}

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

@end
