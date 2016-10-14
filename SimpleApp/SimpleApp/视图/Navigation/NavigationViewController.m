//
//  NavigationViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/9/19.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

+ (void)initialize {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].clipsToBounds = YES;
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        //self.navigationBar.translucent = NO;
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    for (UIView *subVies in self.view.subviews) {
        if ([subVies isKindOfClass:[UINavigationBar class]]) {
            [subVies setFrame:CGRectMake(0, 0, 375, 0)];
            //subVies.backgroundColor = [UIColor whiteColor];
        }
    }
    [super pushViewController:viewController animated:animated];
    viewController.view.frame = CGRectMake(0, 20, 375, 675);
}

@end
