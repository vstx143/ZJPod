//
//  WForbidTextField.m
//  Ouralt
//
//  Created by mac on 2019/3/7.
//  Copyright © 2019年 Tongruan. All rights reserved.
//

#import "WForbidTextField.h"

@implementation WForbidTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
        return NO;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}

@end
