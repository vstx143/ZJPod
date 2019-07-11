//
//  PresentBottomController.m
//  MobileProject
//
//  Created by 陈彤 on 2018/5/29.
//  Copyright © 2018年 wujunyang. All rights reserved.
//

#import "PresentBottomNSObject.h"

@interface PresentBottomNSObject ()

@property (nonatomic,strong) UIView *backView;

@end

@implementation PresentBottomNSObject

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.frame = self.containerView.bounds;
        _backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        if (self.canFreeTap) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelf)];
            tap.numberOfTapsRequired = 1;
            [_backView addGestureRecognizer:tap];
        }
       
    }
    return _backView;
}

- (void)dismissSelf {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    return [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];;
}

- (void)presentationTransitionWillBegin {
    [super presentationTransitionWillBegin];
    self.backView.alpha = 0;
    [self.containerView addSubview:self.backView];
    [UIView animateWithDuration:0.1 animations:^{
        self.backView.alpha = 0.8;
    }];
}

- (void)dismissalTransitionWillBegin {
    [super dismissalTransitionWillBegin];
    [UIView animateWithDuration:0.1 animations:^{
        self.backView.alpha = 0.8;
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    [super dismissalTransitionDidEnd:completed];
    if (completed) {
        [self.backView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    if (self.controllerCGRect.size.height == 0) {
        return [UIScreen mainScreen].bounds;
    }
    return self.controllerCGRect;
}

@end


