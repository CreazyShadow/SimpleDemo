//
//  RayNavigationTransition.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RayNavigationTransition.h"

@implementation RayNavigationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}


/**
 自定义push动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [[transitionContext containerView] addSubview:toView];
    toView.frame = CGRectMake(0, -toView.height, toView.width, toView.height);
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         [toView setFrame:toViewFinalFrame];
                     }
                     completion:^(BOOL finished) {
                         if (![transitionContext transitionWasCancelled]) {
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }
                         else {
                             [toView removeFromSuperview];
                             [transitionContext completeTransition:NO];
                         }
                     }];
}

@end
