//
//  CustomTextField.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/12.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField()<UITextFieldDelegate>

@end

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length + string.length <= _maxLen) {
        return YES;
    }
    
    return NO;
}

@end
