//
//  BaseViewController.h
//  SimpleApp
//
//  Created by wuyp on 16/9/14.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *name;

+ (instancetype)initWithName;

- (instancetype)initWithAge;

@end
