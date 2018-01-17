//
//  IQKeyBoardTextView.m
//  SimpleApp
//
//  Created by wuyp on 2017/12/13.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "IQKeyBoardTextView.h"

@implementation IQKeyBoardTextView

+ (void)show {
    IQKeyBoardTextView *instance = [[IQKeyBoardTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    instance.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:instance];
    
    UIControl *container = [[UIControl alloc] initWithFrame:CGRectMake(50, 300, 200, 300)];
    container.layer.borderColor = [UIColor grayColor].CGColor;
    container.layer.borderWidth = 1.0;
    [instance addSubview:container];
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, 160, 100)];
    text.textColor = [UIColor redColor];
    text.text = @"123223";
    [container addSubview:text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

@end
