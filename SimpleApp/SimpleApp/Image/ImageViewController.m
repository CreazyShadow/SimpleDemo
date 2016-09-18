//
//  ImageViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/8/22.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ImageViewController.h"

#import "TestWebviewViewController.h"

#import <Masonry.h>

#import "EventButton.h"
#import "EventTextField.h"

@interface ImageViewController ()

@property (nonatomic, strong) EventTextField *textField;

@property (nonatomic, strong) EventButton *tipButton;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-  (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - init ui config

- (void)setupSubViews {
    self.textField = [[EventTextField alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
    _textField.keyboardType = UIKeyboardTypeASCIICapable;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_textField];
}

- (void)tipButtonAction {
    NSLog(@"click Button");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestWebviewViewController *vc = [[TestWebviewViewController alloc] init];
    UINavigationController *nvc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nvc pushViewController:vc animated:YES];
}

@end
