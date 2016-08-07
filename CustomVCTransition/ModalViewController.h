//
//  ModalViewController.h
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

- (void)modalViewControllerDidclickedDismissButton:(ModalViewController *)viewcontroller;

@end

@interface ModalViewController : UIViewController
@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;
@end
