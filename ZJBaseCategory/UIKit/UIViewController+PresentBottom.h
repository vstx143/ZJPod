//
//  UIViewController+PresentBottom.h
//  MobileProject
//
//  Created by 陈彤 on 2018/5/29.
//  Copyright © 2018年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PresentBottom) <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSValue *bottomRectValue;
@property (nonatomic, strong) NSNumber *canFreeTapNumber;

- (void)w_presentBottomVC:(UIViewController *)vc bottomRect:(CGRect)bottomRect tapBool:(BOOL)tap;
- (void)w_dismissBottomVC;

@end
