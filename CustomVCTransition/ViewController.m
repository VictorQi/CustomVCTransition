//
//  ViewController.m
//  CustomVCTransition
//
//  Created by v.q on 16/8/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "BouncePressentAnimation.h"
#import "SwipeUpInteractiveTransition.h"
#import "ViewControllerDismissAnimation.h"

@interface ViewController ()
<
ModalViewControllerDelegate,
UIViewControllerTransitioningDelegate
>

@property (nonatomic, strong) ViewControllerDismissAnimation *dismissAnim;
@property (nonatomic, strong) BouncePressentAnimation *presentAnim;
@property (nonatomic, strong) SwipeUpInteractiveTransition *controllerTransition;

@end

@implementation ViewController

// 初始化方法中设置相应的转场动画
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dismissAnim = [ViewControllerDismissAnimation new];
        _presentAnim = [BouncePressentAnimation new];
        _controllerTransition = [SwipeUpInteractiveTransition new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(id)sender {
    ModalViewController *mvc = [[ModalViewController alloc]init];
    mvc.delegate = self;
    mvc.transitioningDelegate = self;
    
    // 为需要交互的mvc绑定transition
    [self.controllerTransition wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)modalViewControllerDidclickedDismissButton:(ModalViewController *)viewcontroller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// presentation的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnim;
}

// dismiss的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnim;
}

// 交互转场的委托实现
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.controllerTransition.interacting ? self.controllerTransition : nil;
}

@end
