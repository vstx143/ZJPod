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

#pragma mark --- 创建单色UIImage
/**
 生成一张到脚图片
 
 @param color 图片颜色
 @return 图片
 */
+ (UIImage *)w_createImageWithColor:(UIColor*) color;
/**
 生成一张到脚图片
 
 @param color 图片颜色
 @param size 大小
 @return 图片
 */
+ (UIImage *)w_createImageWithColor:(UIColor *)color size:(CGSize)size;
/**
 生成一张到脚图片
 
 @param color 图片颜色
 @param raduis 角度
 @param type 要倒的脚
 @return 图片
 */
+ (UIImage *)w_createImageWithColor:(UIColor*) color raduis:(CGFloat)raduis type:(UIRectCorner)type;
/**
 生成一张到脚图片、设置边框颜色
 
 @param color 图片颜色
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param raduis 角度
 @param type 要倒的脚
 @return 图片
 */
+ (UIImage *)w_createImageWithColor:(UIColor*) color borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth raduis:(CGFloat)raduis type:(UIRectCorner)type;


#pragma mark --- 倒角成圆形图片
-(UIImage*)w_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
//指定原图大小（原图太大，边线小，显示的小的话图片压缩小了，边线看不见）
-(UIImage*)w_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor size:(CGSize)size;


#pragma mark --- 根据CIImage生成指定大小的UIImage
+ (UIImage *)w_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withWidth:(CGFloat)imgWidth;


#pragma mark --图片等比缩放
//变到指定大小
- (UIImage*)w_scaleImageWithNewSize:(CGSize)size;
//全显示，等比缩放
- (UIImage*)w_scaleImageGreaterThan:(CGFloat)maxL;
//9宫格方式缩放
- (UIImage *)w_scaleImage;


#pragma mark -- 截屏
+ (UIImage *)w_screenShot;

#pragma mark -- 压缩
//质量压缩（字节）
-(NSData *)w_compressQualityWithMaxLength:(NSInteger)maxLength;
//大小压缩（字节）
-(NSData *)w_compressBySizeWithMaxLength:(NSUInteger)maxLength;
//综合先质量再大小（字节）
-(NSData *)w_compressWithMaxLength:(NSUInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
