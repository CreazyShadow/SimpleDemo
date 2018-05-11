//
//  SHIndexMenuView.h
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/10.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHIndexMenuView : UIView

@property (nonatomic, assign) CGFloat itemH; //< 默认等分
@property (nonatomic, strong) UIFont  *itemFont;
@property (nonatomic, strong) UIColor *itemColor;

@property (nonatomic, strong) NSArray<NSString *> *indexTitlesArray;

@end
