//
//  TestViewController_1.m
//  SimpleCommon
//
//  Created by wuyp on 2017/3/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TestViewController_1.h"

@interface TestViewController_1 ()

@end

@implementation TestViewController_1

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *commonBundle = [[NSBundle mainBundle] URLForResource:@"commonBundle" withExtension:@"bundle"];
    NSString *file = [[NSBundle bundleWithURL:commonBundle] pathForResource:@"life_service" ofType:@"png"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:file];
    UIImageView *imv = [[UIImageView alloc] initWithImage:img];
    imv.frame = CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 200);
    [self.view addSubview:imv];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - event

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
