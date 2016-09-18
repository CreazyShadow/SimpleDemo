//
//  PickerViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/12.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPickerView];
}

#pragma mark - datepicker view

- (void)setupPickerView {
    [self.view addSubview:self.datePicker];
}

- (void)selectDate:(UIDatePicker *)datePicker {
    NSLog(@"%@", datePicker.date);
}

#pragma mark - getter & setter 

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 500)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.date = [NSDate date];
        _datePicker.timeZone = [NSTimeZone localTimeZone];
        [_datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _datePicker;
}

@end
