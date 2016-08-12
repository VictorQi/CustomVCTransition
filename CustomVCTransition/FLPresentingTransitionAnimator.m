//
//  FLPresentingTransitionAnimator.m
//  SwiftLive
//
//  Created by Victor on 16/8/9.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import "FLPresentingTransitionAnimator.h"

static NSTimeInterval const kDefaultDuration = 0.4;
static CGFloat const kInitialScale = 0.01;
static CGFloat const kFinalScale = 1.0;

@implementation FLPresentingTransitionAnimator

- (instancetype)initAnimatorWithAppearing:(BOOL)isAppearing {
    self = [super init];
    if (self) {
        _appearing = isAppearing;
        _duration = kDefaultDuration;
    }
    return self;
}

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.appearing) {
        fromView.userInteractionEnabled = NO;
        
        toView.layer.cornerRadius = 5.0;
        toView.layer.masksToBounds = YES;
        
        toView.layer.affineTransform = CGAffineTransformMakeScale(kInitialScale, kInitialScale);
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:duration animations:^{
            toView.layer.affineTransform = CGAffineTransformMakeScale(kFinalScale, kFinalScale);
            fromView.alpha = 0.5;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    } else {
        
        [UIView animateWithDuration:duration animations: ^{
            fromView.transform = CGAffineTransformMakeScale(kInitialScale, kInitialScale);
            toView.alpha = 1.0;
        } completion: ^(BOOL finished) {
            [fromView removeFromSuperview];
            toView.userInteractionEnabled = YES;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    
    
}

@end
