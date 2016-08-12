//
//  CustomPresentationVC.m
//  CustomVCTransition
//
//  Created by Victor on 16/8/8.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "CustomPresentationVC.h"

@interface CustomPresentationVC ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation CustomPresentationVC

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        self.dimmingView = [[UIView alloc]init];
        self.dimmingView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.4];
        [self.dimmingView setAlpha:0.0];
    }
    
    return self;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [self containerView].bounds;
    
    presentedViewFrame.size = CGSizeMake(floorf(containerBounds.size.width/2.0), floorf(containerBounds.size.height/2.0));
    presentedViewFrame.origin.x = floorf((containerBounds.size.width - presentedViewFrame.size.width)/2.0);
    presentedViewFrame.origin.y = floorf((containerBounds.size.height - presentedViewFrame.size.height)/2.0);
    
    return presentedViewFrame;
}

- (void)presentationTransitionWillBegin {
    UIView *containerView = [self containerView];
    UIViewController *presentedVC = [self presentedViewController];
    
    [self.dimmingView setFrame:containerView.bounds];
    [self.dimmingView setAlpha:0.0];
    
    [containerView insertSubview:self.dimmingView atIndex:0];
    
    if ([presentedVC transitionCoordinator]) {
        [[presentedVC transitionCoordinator]animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            [self.dimmingView setAlpha:1.0];
        } completion:nil];
    } else {
        [self.dimmingView setAlpha:1.0];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    if ([[self presentedViewController] transitionCoordinator]) {
        [[[self presentedViewController] transitionCoordinator]
         animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
             [[self dimmingView] setAlpha:0.0];
         } completion:nil];
    } else {
        [[self dimmingView] setAlpha:0.0];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}



@end
