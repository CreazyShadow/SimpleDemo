//
//  SelectDatePickerView.m
//  SimpleApp
//
//  Created by wuyp on 16/9/26.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SelectDatePickerView.h"

@interface SelectDatePickerView()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, copy) void (^confirm)(NSDate *);

@property (nonatomic, copy) void (^cancel)();

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation SelectDatePickerView

+ (void)showWithConfirm:(void (^)(NSDate *))confirm Cancel:(void (^)())cancel {
    SelectDatePickerView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelectDatePickerView" owner:nil options:nil] lastObject];
    view.frame = [UIScreen mainScreen].bounds;
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.datePicker.datePickerMode = UIDatePickerModeDate;
    
    view.confirm = [confirm copy];
    view.cancel = [cancel copy];
}

- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
    
    if (self.confirm) {
        self.confirm(_datePicker.date);
    }
}

- (IBAction)confirmAction:(id)sender {
    [self removeFromSuperview];
    
    if (self.cancel) {
        self.cancel();
    }
}

@end
