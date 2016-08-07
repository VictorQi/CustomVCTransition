//
//  SwipeUpInteractiveTransition.m
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "SwipeUpInteractiveTransition.h"

@interface SwipeUpInteractiveTransition ()

@property (nonatomic, readwrite, assign) BOOL interacting;
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, weak) UIViewController *presentingVC;

@end

@implementation SwipeUpInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewcontroller {
    self.presentingVC = viewcontroller;
    [self prepareGestureReconizerInView:viewcontroller.view];
}

- (void)prepareGestureReconizerInView:(UIView *)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture {
    UIView *gestureMainView = gesture.view.superview;
    CGPoint translation = [gesture translationInView:gestureMainView];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES; //  更新interacting标识
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 计算手势移动的百分比
            CGFloat screenHei = [UIScreen mainScreen].bounds.size.height;
            CGFloat fraction = translation.y / screenHei;
            // 保证处在0-1的区间
            fraction = fminf(fmax(fraction, 0.0), 1.0);
            NSLog(@"fraction is %f", fraction);
            self.shouldComplete = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 手势结束,确定transition是否需要进行
            self.interacting = NO;
            if (!self.shouldComplete
                || gesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
        }
        default:
            break;
    }
}

@end
