//
//  BouncePressentAnimation.m
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "BouncePressentAnimation.h"

@interface BouncePressentAnimation ()

@end

@implementation BouncePressentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // get controller from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // set init frame for toVC's view
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    NSLog(@"toVC's view frame is: %@, final frame is: %@", NSStringFromCGRect(toVC.view.frame), NSStringFromCGRect(finalFrame));
    
    // add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // do animation now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
