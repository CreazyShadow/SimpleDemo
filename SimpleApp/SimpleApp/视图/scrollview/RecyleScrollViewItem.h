//
//  RecyleScrollViewItem.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecyleScrollViewItem : UIView

@property (nonatomic, copy) NSString *identify;

- (instancetype)initWithIdentify:(NSString *)identify;

@end
