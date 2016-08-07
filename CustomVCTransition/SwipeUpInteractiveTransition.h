//
//  SwipeUpInteractiveTransition.h
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, readonly, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewcontroller;

@end
