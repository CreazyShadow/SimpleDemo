//
//  FitCommentViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/11/1.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "FitCommentViewController.h"

@interface FitCommentViewController ()

@end

@implementation FitCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - touch event 

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callPhone];
}

#pragma mark - SDK适配

#pragma mark - OpenURL废弃


/**
 打电话功能
 */
- (void)callPhone {
    NSURL *url = [NSURL URLWithString:@"tel:18516518602"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
//    [[UIApplication sharedApplication] openURL:url];
}

@end
