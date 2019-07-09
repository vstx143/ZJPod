//
//  UIBarButtonItem+WExtension.h
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem(WExtension)
/**
 *  返回没有调整图片
 */
+ (UIBarButtonItem *)w_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;

/**
 *  没有文字调整的按钮
 */
+ (UIBarButtonItem *)w_itemWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action;

/**
 *  没有文字调整的按钮 文字颜色
 */
+ (UIBarButtonItem *)w_itemWithName:(NSString *)Name font:(CGFloat)font color:(UIColor *)titleColor target:target action:(SEL)action;

/**
 *  返回调整文字
 */
+ (NSArray *)w_itemsWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action;

/**
 *  返回调整图片
 */
+ (NSArray *)w_itemsWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
