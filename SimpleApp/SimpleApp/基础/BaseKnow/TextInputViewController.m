//
//  TextInputViewController.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TextInputViewController.h"

@interface TextInputViewController ()

@property (nonatomic, strong) UITextView *textview;

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation TextInputViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self buildSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - event 

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.textview becomeFirstResponder];
//    [self.view endEditing:YES];
}

#pragma mark - init subviews

- (void)buildSubViews {
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bing.com"]];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 500, 200, 40)];
    [self.view addSubview:_textview];
}

#pragma mark - keyboard notification

- (void)keyboardFrameChange:(NSNotificationCenter *)nf {
    NSLog(@"-----%@", nf);
}

- (void)keyboardWillShow:(NSNotification *)nf {
    NSLog(@"----- show");
}

- (void)keyboardWillHidden:(NSNotification *)nf {
    NSLog(@"----- hidden");
}

@end
