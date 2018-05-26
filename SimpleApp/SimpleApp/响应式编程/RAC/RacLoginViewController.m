//
//  RacLoginViewController.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/7.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "RacLoginViewController.h"

#import "RACLoginViewModel.h"

#import <ReactiveObjC.h>

@interface RacLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) RACLoginViewModel *loginVM;

@end

@implementation RacLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginVM = [[RACLoginViewModel alloc] init];
    [[_loginVM fetchData] subscribeNext:^(UserModel * _Nullable x) {
        self.nameTF.text = x.name;
        self.pwdTF.text = x.password;
    }];
     
     [self.nameTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
         
     }];
}

- (IBAction)loginAction:(id)sender {
    [[_loginVM loginWithUser:nil] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(x.boolValue ? @"登陆成功" : @"登陆失败");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - 设置绑定信号

- (void)bindingSingle {
   
}

@end
