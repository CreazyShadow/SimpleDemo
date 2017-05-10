//
//  BaseView.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

@property (nonatomic, copy) void(^clickIndex)(NSInteger index);

- (void)updateHeaderTitle:(NSString *)title index:(NSInteger)index;

@end
