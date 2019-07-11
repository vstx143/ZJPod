//
//  UIViewController+PresentBottom.m
//  MobileProject
//
//  Created by 陈彤 on 2018/5/29.
//  Copyright © 2018年 wujunyang. All rights reserved.
//

#import "UIViewController+PresentBottom.h"
#import <objc/runtime.h>
#import "PresentBottomNSObject.h"

static char *BottomRectKey = "BottomRectKey";

@implementation UIViewController (PresentBottom)

- (void)setCanFreeTapNumber:(NSNumber *)canFreeTapNumber {
    objc_setAssociatedObject(self, @selector(canFreeTapNumber), canFreeTapNumber, OBJC_ASSOCIATION_COPY);
}

- (NSNumber *)canFreeTapNumber {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBottomRectValue:(NSValue *)bottomRectValue {
    objc_setAssociatedObject(self, BottomRectKey, bottomRectValue, OBJC_ASSOCIATION_COPY);
}

- (NSValue *)bottomRectValue {
    return objc_getAssociatedObject(self, BottomRectKey);
}

#pragma mark - action

- (void)w_presentBottomVC:(UIViewController *)vc bottomRect:(CGRect)bottomRect tapBool:(BOOL)tap{
    
    self.bottomRectValue = [NSValue valueWithCGRect:bottomRect];
    self.canFreeTapNumber = [NSNumber numberWithBool:tap];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)w_dismissBottomVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    PresentBottomNSObject *present = [[PresentBottomNSObject alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
    present.controllerCGRect = self.bottomRectValue.CGRectValue;
    present.canFreeTap = self.canFreeTapNumber.boolValue;

    return present;
}

@end
