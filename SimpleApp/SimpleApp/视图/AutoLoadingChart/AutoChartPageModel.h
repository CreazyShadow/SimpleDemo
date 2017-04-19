//
//  AutoChartPageModel.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoChartPageModel : NSObject

/**
 x轴刻度
 */
@property (nonatomic, strong) NSArray<NSString *> *xSource;

/**
 y轴的数值
 */
@property (nonatomic, strong) NSArray<NSString *> *ySource;

/**
 y轴分组数值
 */
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *yGroupSource;

@end
