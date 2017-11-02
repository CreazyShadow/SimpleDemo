//
//  BaseViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/14.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "BaseViewController.h"

#import <objc/runtime.h>

typedef void(^HandlerBlock)(id repsonse);

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}


- (void)jumpNativeDealViewControllerparam:(id)data WVJBResponseCallback:(void(^)(id data))responseCallback {
    
    
    
}

- (void)print {
    NSLog(@"----base---print");
}

#pragma mark - override

#pragma mark - construction

- (instancetype)initWithAge {
    self = [super init];
    return self;
}

+ (instancetype)initWithName {
    BaseViewController *base = [[BaseViewController alloc] init];
    return base;
}

@end
