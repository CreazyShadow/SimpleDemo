//
//  NavigationAnimationViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "NavigationAnimationViewController.h"

#import "RayNavigationTransition.h"

#import "FromViewController.h"

//UIPercentDrivenInteractiveTransition 交互动画

@interface NavigationAnimationViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation NavigationAnimationViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - UIPercentDrivenInteractiveTransition 交互动画

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    static CGFloat beginY;
    CGFloat currentY = [gesture translationInView:window].y;
    CGFloat percent = (currentY - beginY) / CGRectGetHeight(window.bounds);
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            beginY = [gesture translationInView:window].y;
            [self.navigationController pushViewController:[FromViewController new] animated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.interactiveTransition updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [self.interactiveTransition finishInteractiveTransition];
            }
            else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
    
    NSLog(@"---%lf ----%lf ----%lf ----%lf", beginY, currentY, CGRectGetHeight(window.bounds), percent);
}

#pragma mark - UINavigationControllerDelegate

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    
//    if (operation == UINavigationControllerOperationPush) {
//        return [RayNavigationTransition new];
//    }
//    
//    return nil;
//}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactiveTransition;
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController pushViewController:[FromViewController new] animated:YES];
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
