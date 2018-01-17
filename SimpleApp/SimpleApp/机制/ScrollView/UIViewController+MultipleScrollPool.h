//
//  UIViewController+MultipleScrollPool.h
//  SimpleApp
//
//  Created by wuyp on 2017/12/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MultipleScrollPool)

- (void)cacheScrollView:(UIScrollView *)scroll;

- (NSArray<UIScrollView *> *)allScroll;

- (void)cleanScrollPool;

@end
