//
//  ToolBarXibViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/9/22.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ToolBarXibViewController.h"

@interface ToolBarXibViewController ()

@end

@implementation ToolBarXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildToolBar];
}

#pragma mark - subviews

- (void)buildToolBar {
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, 375, 40)];
    
    UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAction)];
    [bar setItems:@[confirm]];
    
    [self.view addSubview:bar];
}

- (void)confirmAction {
    NSLog(@"----");
}
@end
