//
//  TextFieldViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/12.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TextFieldViewController.h"

#import "CustomTextField.h"

@interface TextFieldViewController () <UITextFieldDelegate>

@property (nonatomic, strong) CustomTextField *textField;

@end

@implementation TextFieldViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    _textField = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 100, 100, 30)];
    _textField.maxLen = 6;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.delegate = self;
    [self.view addSubview:_textField];
}

#pragma mark - init subviews

#pragma mark - event

#pragma mark - UITextFieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField.text.length + string.length <= 4) {
//        return YES;
//    }
//    
//    return NO;
//}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
