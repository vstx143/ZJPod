//
//  UIImage+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UIImage+WExtension.h"

@implementation UIImage(WExtension)

#pragma mark --- 创建单色UIimage
+ (UIImage *)w_createImageWithColor:(UIColor*) color {
   return [UIImage w_createImageWithColor:color size:CGSizeMake(1, 1)];
}
+(UIImage *)w_createImageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIImage *)w_createImageWithColor:(UIColor*) color raduis:(CGFloat)raduis type:(UIRectCorner)type{
    return [self w_createImageWithColor:color borderColor:UIColor.clearColor borderWidth:1 raduis:raduis type:type];
}
+ (UIImage *)w_createImageWithColor:(UIColor*) color borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth raduis:(CGFloat)raduis type:(UIRectCorner)type{
    UIImage *image =  [UIImage w_createImageWithColor:color size:CGSizeMake((raduis+1)*2, (raduis+1)*2)];
    //
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetLineWidth(context, borderWidth);
    CGRect rect=CGRectMake(borderWidth, borderWidth,image.size.width-borderWidth*2, image.size.height-borderWidth*2);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:type cornerRadii:CGSizeMake(raduis, raduis)];
    
    CGContextAddPath(context, maskPath.CGPath);
    CGContextClip(context);
    [image drawInRect:rect];
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    theImage = [theImage stretchableImageWithLeftCapWidth:image.size.width/2+1 topCapHeight:image.size.height/2+1];
    return theImage;
}
-(UIImage*)w_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    return [self w_circleImageWithBorderWidth:borderWidth borderColor:borderColor size:self.size];
}
-(UIImage*)w_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor size:(CGSize)size{
    // 2.开启上下文
    UIImage *image = [self w_scaleImageWithNewSize:size];
    CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 1.0);
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = image.size.width * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(ctx);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 */
+ (UIImage *)w_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withWidth:(CGFloat)imgWidth {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(imgWidth/CGRectGetWidth(extent), imgWidth/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
#pragma mark --图片等比缩放
- (UIImage*)w_scaleImageWithNewSize:(CGSize)size{
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
- (UIImage*)w_scaleImageGreaterThan:(CGFloat)maxL {
    UIImage * res;
    UIImage * img = self;
    res = img;
    float height = img.size.height;
    float width = img.size.width;
    float bigger = height > width ? height : width;
    float coefficient = 1.0;
    int maxPix = maxL;
    if (bigger > maxPix) {
        coefficient = maxPix / bigger;
        res = [img w_scaleImageWithNewSize:CGSizeMake(width * coefficient, height * coefficient)];
    }
    return res;
}
- (UIImage *)w_scaleImage{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}
#pragma mark -- 截屏
+ (UIImage *)w_screenShot {
    // 1. 获取到窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 2. 开始上下文
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 0);
    // 3. 将 window 中的内容绘制输出到当前上下文
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    // 4. 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}
#pragma mark -- 压缩
- (NSData *)w_compressQualityWithMaxLength:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}
-(NSData *)w_compressBySizeWithMaxLength:(NSUInteger)maxLength{
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}
-(NSData *)w_compressWithMaxLength:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}
@end
