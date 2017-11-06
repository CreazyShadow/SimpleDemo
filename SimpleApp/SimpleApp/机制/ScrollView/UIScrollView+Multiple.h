//
//  UIScrollView+Multiple.h
//  SimpleApp
//
//  Created by wuyp on 2017/11/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScrollOffsetState) {
    ScrollOffsetStateMin,
    ScrollOffsetStateCenter,
    ScrollOffsetStateMax
};

@interface UIScrollView (Multiple)

@property (nonatomic, assign) BOOL needMultipleScroll;

@property (nonatomic, assign) ScrollOffsetState offsetState;

@property (nonatomic, assign) BOOL isSuperScroll;

@end
