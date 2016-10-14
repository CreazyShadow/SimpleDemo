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
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    for (int i = 0; i < 10; i++) {
        UIButton *temp = [[UIButton alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 100)];
        temp.backgroundColor = [UIColor blueColor];
        temp.layer.borderColor = [UIColor redColor].CGColor;
        temp.layer.borderWidth = 1;
        [temp addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:temp];
    }
    
    scrollview.contentSize = CGSizeMake(1000, 0);
    [self.view addSubview:scrollview];
}

- (void)action {
    NSLog(@"-----action");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

@end
