//
//  ModalViewController.m
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ModalViewController.h"
#import "CustomPresentationVC.h"
#import "FLPresentingTransitionAnimator.h"

@interface ModalViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ModalViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Dismiss me!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *x = [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor];
    NSLayoutConstraint *y = [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
    
    [NSLayoutConstraint activateConstraints:@[x, y]];
}

- (void)buttonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidclickedDismissButton:)]) {
        [self.delegate modalViewControllerDidclickedDismissButton:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Transition

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    if (presented == self) {
        CustomPresentationVC *myPresentation = [[CustomPresentationVC alloc]
                                                initWithPresentedViewController:presented presentingViewController:presenting];
        return myPresentation;
    } else {
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (presented == self) {
        return [[FLPresentingTransitionAnimator alloc]initAnimatorWithAppearing:YES];
    } else {
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (dismissed == self) {
        return [[FLPresentingTransitionAnimator alloc]initAnimatorWithAppearing:NO];
    } else {
        return nil;
    }
}
@end
