//
//  FirstViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/6/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ScrapeView.h"
#import "TestWebviewViewController.h"
#import "DrawViewController.h"

#import <Person.h>

#import "SubView.h"

#import "MasonryViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) ScrapeView *scrapeView;

@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FirstViewController";
    
    [self setupSubViews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecondViewController *second = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
    
}

#pragma mark - override

- (void)print {
    NSLog(@"first view ------print");
}

#pragma mark - init

- (void)setupSubViews {
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 100, 30)];
    _button1.layer.shadowColor = [UIColor redColor].CGColor;
    _button1.layer.shadowOffset = CGSizeMake(0, 4);
    _button1.layer.shadowRadius = 1;
    _button1.layer.shadowOpacity = 0.6;
    [_button1 setTitle:@"Button1" forState:UIControlStateNormal];
    _button1.backgroundColor = [UIColor greenColor];
    [_button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];

}

#pragma mark - event responder

- (void)clickButton1 {
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

#pragma mark - getter & setter 

- (ScrapeView *)scrapeView {
    if (!_scrapeView) {
        _scrapeView = [[ScrapeView alloc] init];
    }
    
    return _scrapeView;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 180, 200, 40)];
//        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 1;
    }
    
    return _stackView;
}


@end
