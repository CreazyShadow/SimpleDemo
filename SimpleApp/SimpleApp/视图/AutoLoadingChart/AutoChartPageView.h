//
//  AutoChartPageItem.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutoChartPageModel.h"

@interface AutoChartPageView : UIView

@property (nonatomic, strong) AutoChartPageModel *pageModel;

- (instancetype)initWithYScaleCount:(NSInteger)yScaleCount;

- (instancetype)initWithYScaleCount:(NSInteger)yScaleCount frame:(CGRect)frame;

@end
