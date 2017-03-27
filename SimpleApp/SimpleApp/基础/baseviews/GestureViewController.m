//
//  GestureViewController.m
//  SimpleApp
//
//  Created by wuyp on 2016/12/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 100, 30)];
    textField.backgroundColor = [UIColor greenColor];
    textField.delegate = self;
    textField.textAlignment = NSTextAlignmentLeft;
    self.textField = textField;
    [self.view addSubview:textField];
    
    self.view.exclusiveTouch = NO;
}

@end
