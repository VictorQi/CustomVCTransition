//
//  FLPresentingTransitionAnimator.h
//  SwiftLive
//
//  Created by Victor on 16/8/9.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface FLPresentingTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  appearing, YES表示presenting的Animator，NO表示dismissals的Animator
 */
@property (nonatomic, readonly, assign, getter=isAppearing) BOOL appearing;

@property (nonatomic, assign) CGFloat duration;

- (instancetype)initAnimatorWithAppearing:(BOOL)isAppearing;

@end
