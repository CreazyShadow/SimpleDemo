//
//  CustomWindow.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/17.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "CustomWindow.h"

@interface CustomWindow()

@end

@implementation CustomWindow

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

#pragma mark - override

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
}

#pragma mark - event

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

@end
