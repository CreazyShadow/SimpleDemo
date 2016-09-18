//
//  AutoLayoutViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/18.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "AutoLayoutViewController.h"

@interface AutoLayoutViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [comp setMonth:comp.month + 10];
    NSLog(@"%@ %@",[NSDate date] ,[calendar dateFromComponents:comp]);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

@end
