//
//  UIPageControllerViewControllerDemo.m
//  SimpleApp
//
//  Created by wuyp on 16/9/12.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "UIPageControllerViewControllerDemo.h"
#import "PageViewControllerChild.h"

@interface UIPageControllerViewControllerDemo () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageController;

@end

@implementation UIPageControllerViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"-----");
    self.pageController.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark - pageviewcontroller delegate & datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    PageViewControllerChild *child = [[PageViewControllerChild alloc] init];
    return child;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    PageViewControllerChild *child = [[PageViewControllerChild alloc] init];
    return child;
}

#pragma mark - lazy

- (UIPageViewController *)pageController {
    if (!_pageController) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
        PageViewControllerChild *child = [[PageViewControllerChild alloc] init];
        [_pageController setViewControllers:@[child] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self addChildViewController:_pageController];
        [self.view addSubview:_pageController.view];
    }
    
    return _pageController;
}

@end
