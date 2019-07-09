//
//  UIImage+WExtension.h
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(WExtension)

/**
 *  返回拉伸图片
 */
+ (UIImage *)w_resizedImage:(NSString *)name;
/**
 *  用颜色返回一张图片
 */
+ (UIImage *)w_createImageWithColor:(UIColor*) color;
/**
 *  用颜色返回一张图片自定义倒脚图
 */
+ (UIImage *)w_createImageWithColor:(UIColor*) color raduis:(CGFloat)raduis type:(UIRectCorner)type;

/**
 生成一张到脚图片、设置边框颜色

 @param color 图片颜色
 @param boundColor 边框颜色
 @param boundWidth 边框宽度
 @param raduis 角度
 @param type 要倒的脚
 @return 图片
 */
+ (UIImage *)w_createImageWithColor:(UIColor*) color boundColor:(UIColor*)boundColor boundWidth:(CGFloat)boundWidth raduis:(CGFloat)raduis type:(UIRectCorner)type;
/**
 *  带边框的图片
 *  @param name        图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)w_circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (instancetype)w_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  使用图像名创建图像视图
 *
 *  @param imageName 图像名称
 *
 *  @return UIImageView
 */
+ (instancetype)w_imageViewWithImageName:(NSString *)imageName;

/**
 * 圆形图片
 */
- (UIImage *)w_circleImage;
- (UIImage*)w_transformtoSize:(CGSize)Newsize;

/**
 不模糊缩放图片返回新尺寸图片
 */
- (UIImage *)w_scaleFromImage:(UIImage *)image toSize:(CGSize)size;

- (UIImage *)w_transformToCircularBeadWithRaduis:(CGFloat)raduis;

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 */
+ (UIImage *)w_createNonInterpolatedUIImageFormCIImage:(CIImage *)image  withWidth:(CGFloat)imgWidth;

- (UIImage*)w_resizeImageGreaterThan:(CGFloat)maxL;
- (UIImage*)w_resizeImageWithNewSize:(CGSize)newSize;
/**
 *  获取屏幕截图
 *
 *  @return 屏幕截图图像
 */
+ (UIImage *)w_screenShot;
@end

NS_ASSUME_NONNULL_END
