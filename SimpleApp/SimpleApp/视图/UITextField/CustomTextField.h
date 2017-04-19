//
//  CustomTextField.h
//  SimpleApp
//
//  Created by wuyp on 2017/4/12.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTextFieldDelegate <UITextFieldDelegate>

@end

@interface CustomTextField : UITextField

@property (nonatomic, assign) NSInteger maxLen;

@property (nonatomic, weak) id<CustomTextFieldDelegate> customDelegate;

@end
