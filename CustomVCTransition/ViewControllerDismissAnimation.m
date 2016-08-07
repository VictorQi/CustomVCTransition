//
//  ViewControllerDismissAnimation.m
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ViewControllerDismissAnimation.h"

@implementation ViewControllerDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];;
    
    //为fromVC设置初始的frame
    CGFloat screenHei = [UIScreen mainScreen].bounds.size.height;
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initialFrame, 0, screenHei);
    NSLog(@"fromVC's view initialFrame is: %@, final frame is: %@", NSStringFromCGRect(initialFrame), NSStringFromCGRect(finalFrame));
    
    // 将toView的view添加到containerView中，并将其放到后面先不显示
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}

@end
