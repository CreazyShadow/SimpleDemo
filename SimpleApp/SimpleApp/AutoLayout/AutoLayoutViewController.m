//
//  AutoLayoutViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/15.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "AutoLayoutViewController.h"

#import "ChildTableViewCell.h"

#import "ProductSliderTableViewCell.h"
#import "SelectDatePickerView.h"

@interface AutoLayoutViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:23 green:24 blue:25 alpha:1];
    self.datePicker.timeZone = [NSTimeZone systemTimeZone];
    
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
  }

- (void)datePickerChanged:(UIDatePicker *)datePicker {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate:datePicker.date];
    
}

@end
