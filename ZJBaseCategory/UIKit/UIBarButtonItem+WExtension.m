//
//  UIBarButtonItem+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UIBarButtonItem+WExtension.h"

@implementation UIBarButtonItem(WExtension)
/**
 *  没有图片调整的按钮
 */
+ (UIBarButtonItem *)w_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName != nil) {
        [button setBackgroundImage: [UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    // 设置按钮的尺寸为背景图片的尺寸
    button.frame =CGRectMake(button.frame.origin.x, button.frame.origin.y, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    button.adjustsImageWhenHighlighted = NO;
    //监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 *  没有文字调整的按钮
 */
+ (UIBarButtonItem *)w_itemWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitle:Name forState:UIControlStateNormal];
    [btn sizeToFit];
    //监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  没有文字调整的按钮 文字颜色
 */
+ (UIBarButtonItem *)w_itemWithName:(NSString *)Name font:(CGFloat)font color:(UIColor *)titleColor target:target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitle:Name forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:0];
    [btn sizeToFit];
    //监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (NSArray *)w_itemsWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitle:Name forState:UIControlStateNormal];
    [btn sizeToFit];
    //监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return @[negativeSpacer, item];
}

+ (NSArray *)w_itemsWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIBarButtonItem *item = [UIBarButtonItem w_itemWithImageName:imageName highImageName:highImageName target:target action:action];
    return @[negativeSpacer, item];
}
@end
