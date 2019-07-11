//
//  UIImage+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UIImage+WExtension.h"

@implementation UIImage(WExtension)
/**
 *  拉伸图片
 */
+ (UIImage *)w_resizedImage:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)w_createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
    
    UIImage *image =  [UIImage w_createImageWithColor:color size:CGSizeMake((raduis+1)*2, (raduis+1)*2)];
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect=CGRectMake(0.0f, 0.0f,image.size.width, image.size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:type cornerRadii:CGSizeMake(raduis, raduis)];
    
    CGContextAddPath(context, maskPath.CGPath);
    CGContextClip(context);
    [image drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    theImage = [theImage stretchableImageWithLeftCapWidth:image.size.width/2+1 topCapHeight:image.size.height/2+1];
    return theImage;
}
+ (UIImage *)w_createImageWithColor:(UIColor*) color boundColor:(UIColor*)boundColor boundWidth:(CGFloat)boundWidth raduis:(CGFloat)raduis type:(UIRectCorner)type{
    UIImage *image =  [UIImage w_createImageWithColor:color size:CGSizeMake((raduis+1)*2, (raduis+1)*2)];
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, boundColor.CGColor);
    CGContextSetLineWidth(context, boundWidth);
    CGRect rect=CGRectMake(boundWidth, boundWidth,image.size.width-boundWidth*2, image.size.height-boundWidth*2);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:type cornerRadii:CGSizeMake(raduis, raduis)];
    
    CGContextAddPath(context, maskPath.CGPath);
    [image drawInRect:rect];
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    theImage = [theImage stretchableImageWithLeftCapWidth:image.size.width/2+1 topCapHeight:image.size.height/2+1];
    return theImage;
}
+ (instancetype)w_circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(instancetype)w_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 1.加载原图
    UIImage *oldImage = self;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width;
    CGFloat imageH = oldImage.size.height;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(ctx);
    [oldImage drawInRect:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (instancetype)w_imageViewWithImageName:(NSString *)imageName {
    
    return [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
}

/**
 *  圆形图片
 */
- (UIImage *)w_circleImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)w_transformtoSize:(CGSize)Newsize

{
    
    // 创建一个bitmap的context
    
    UIGraphicsBeginImageContextWithOptions(Newsize, NO, 2);
    
    // 绘制改变大小的图片
    
    [self drawInRect:CGRectMake(0,0, Newsize.width, Newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage* TransformedImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    
    return TransformedImg;
    
}

-(UIImage *)w_scaleFromImage:(UIImage *)image toSize:(CGSize)size{
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
-(UIImage *)w_transformToCircularBeadWithRaduis:(CGFloat)raduis{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, raduis, 0);
    CGContextAddLineToPoint(context, self.size.width - raduis, 0);
    CGContextAddQuadCurveToPoint(context, self.size.width, 0, self.size.width, raduis);
    CGContextAddLineToPoint(context, self.size.width, self.size.height - raduis);
    CGContextAddQuadCurveToPoint(context, self.size.width, self.size.height, self.size.width -raduis, self.size.height);
    CGContextAddLineToPoint(context, raduis, self.size.height);
    CGContextAddQuadCurveToPoint(context, 0, self.size.height, 0, self.size.height - raduis);
    CGContextAddLineToPoint(context, 0, raduis);
    CGContextAddQuadCurveToPoint(context, 0, 0, raduis, 0);
    CGContextClip(context);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
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
- (UIImage*)w_resizeImageGreaterThan:(CGFloat)maxL {
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
        res = [img w_resizeImageWithNewSize:CGSizeMake(width * coefficient, height * coefficient)];
    }
    return res;
}

- (UIImage*)w_resizeImageWithNewSize:(CGSize)newSize
{
    CGFloat newWidth = newSize.width;
    CGFloat newHeight = newSize.height;
    // Resize image if needed.
    float width = self.size.width;
    float height = self.size.height;
    // fail safe
    if (width == 0 || height == 0)
        return self;
    
    //float scale;
    
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //NSData *jpeg = UIImageJPEGRepresentation(image, 0.8);
        return resized;
    }
    return self;
}
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
@end
