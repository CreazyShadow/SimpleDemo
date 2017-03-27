//
//  EventViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/4.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "EventViewController.h"

#import "SuperEventView.h"
#import "ChildEventView.h"

@interface EventViewController ()

@property (nonatomic, strong) SuperEventView *superEventView;
@property (nonatomic, strong) ChildEventView *childEventView;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.superEventView];
    [self.view addSubview:self.childEventView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 400, 200)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.view addSubview:datePicker];
}

#pragma mark - lazy

- (SuperEventView *)superEventView {
    if (!_superEventView) {
        _superEventView = [[SuperEventView alloc] initWithFrame:CGRectMake(0, 70, 100, 40)];
        _superEventView.backgroundColor = [UIColor redColor];
    }
    
    return _superEventView;
}

- (ChildEventView *)childEventView {
    if (!_childEventView) {
        _childEventView = [[ChildEventView alloc] initWithFrame:CGRectMake(0, 120, 100, 30)];
        _childEventView.backgroundColor = [UIColor blueColor];
    }
    
    return _childEventView;
}



@end
