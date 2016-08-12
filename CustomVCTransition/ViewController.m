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
#import "CustomPresentationVC.h"
#import "ViewInstrictSize.h"
#import "Masonry.h"

@interface ViewController ()
<
ModalViewControllerDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) ViewControllerDismissAnimation *dismissAnim;
@property (nonatomic, strong) BouncePressentAnimation *presentAnim;
@property (nonatomic, strong) SwipeUpInteractiveTransition *controllerTransition;
@property (nonatomic, strong) ViewInstrictSize *niceView;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

#pragma mark - Init Method
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

#pragma mark - VC Method Override

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.niceView = [ViewInstrictSize new];
    self.niceView.text = @"时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得仙人之旧馆。";
    self.niceView.image = [UIImage imageNamed:@"signInLogo"];
    [self.view addSubview:self.niceView];
    
    [self.niceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.centerX.equalTo(self.view.mas_centerX);
        make.leading.greaterThanOrEqualTo(self.view.mas_leading).offset(30);
    }];
    
    self.textField = [[UITextField alloc]init];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor cyanColor];
    self.textField.textColor = [UIColor blackColor];
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.placeholder = @"haha";
    self.textField.font = [UIFont systemFontOfSize:14.0];
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.view.mas_bottom).offset(-30);
        make.leading.equalTo(self.view.mas_leading).offset(30);
        make.trailing.equalTo(self.view.mas_trailing).offset(-30);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Click me!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.baseline.equalTo(self.niceView.mas_top).offset(-30);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard Notification

- (void)keyBoardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    
    self.view.frame = CGRectOffset(self.view.frame, 0, -height);
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillDismiss:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    
    self.view.frame = CGRectOffset(self.view.frame, 0, +height);
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - ModalVC Delegate

- (void)buttonClick:(id)sender {
    ModalViewController *mvc = [[ModalViewController alloc]init];
    mvc.delegate = self;
    
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)modalViewControllerDidclickedDismissButton:(ModalViewController *)viewcontroller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.niceView.text = textField.text;
}



@end
