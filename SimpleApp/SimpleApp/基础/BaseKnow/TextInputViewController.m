//
//  TextInputViewController.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TextInputViewController.h"

@interface TextInputViewController ()

@property (nonatomic, strong) UITextView *textview;

@end

@implementation TextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self buildSubViews];
}


#pragma mark - init subviews

- (void)buildSubViews {
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 564, 200, 40)];
    [self.view addSubview:_textview];
}

@end
