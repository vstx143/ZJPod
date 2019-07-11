//
//  UILabel+WExtension.h
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(WExtension)
/**
 * 创建 UILabel
 *
 *  @param title    标题
 *  @param color    标题颜色
 *  @param fontSize 字体大小
 *
 *  @return UILabel(文本水平居中)
 */
+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize;


/**
 * 创建 UILabel
 *
 *  @param title    标题
 *  @param color    标题颜色
 *  @param font     字体
 *
 *  @return UILabel(文本水平居中)
 */
+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;


/**
 *  创建 UILabel
 *
 *  @param title     标题
 *  @param color     标题颜色
 *  @param fontSize  字体大小
 *  @param alignment 对齐方式
 *
 *  @return UILabel
 */
+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;


/**
 *  创建 UILabel
 *
 *  @param title     标题
 *  @param color     标题颜色
 *  @param font      字体
 *  @param alignment 对齐方式
 *
 *  @return UILabel
 */
+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment;

/**
 添加图片
 
 @param image 图片
 @param rect bounds
 @param index 添加位置
 */
- (void)w_addAttchmentImage:(UIImage *)image andBounds:(CGRect)rect atIndex:(NSInteger)index;

/**
 添加属性
 
 @param att 属性
 @param range 范围
 */
- (void)w_addSingleAttributed:(NSDictionary *)att ofRange:(NSRange)range;

//异步获取图片
-(void)w_httpLabelLeftImage:(NSString *)imgUrl label:(UILabel *)label imageX:(CGFloat)imageX imageY:(CGFloat)imageY imageH:(CGFloat)imageH atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
