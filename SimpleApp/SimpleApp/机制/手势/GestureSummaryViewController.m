//
//  GestureSummaryViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/11.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "GestureSummaryViewController.h"

#import "GestureSummary_ResponseTime.h"

@interface GestureSummaryViewController ()

@end

@implementation GestureSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    GestureSummary_ResponseTime *view = [[GestureSummary_ResponseTime alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
}

@end
