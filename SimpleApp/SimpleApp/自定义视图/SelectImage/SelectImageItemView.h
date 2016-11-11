//
//  SelectImageItemView.h
//  SimpleCommon
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectImageItemView : UIView

@property (nonatomic, strong) id backgroundImage;

@property (nonatomic, copy) void(^delEvent)(SelectImageItemView *item);

@end
