//
//  UILabel+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UILabel+WExtension.h"

@implementation UILabel(WExtension)
+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize {
    return [self w_labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter];
}

+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    [label sizeToFit];
    
    return label;
}

+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    return [self w_labelWithTitle:title color:color font:font alignment:NSTextAlignmentCenter];
}

+ (instancetype)w_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    [label sizeToFit];
    return label;
}


- (void)w_addAttchmentImage:(UIImage *)image andBounds:(CGRect)rect atIndex:(NSInteger)index{
    NSTextAttachment* attchment = [NSTextAttachment new];
    attchment.image = image;
    attchment.bounds = rect;
    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attchment];
    NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:self.text];
    [matt insertAttributedString:att atIndex:index];
    self.attributedText = matt;
}
- (void)w_addSingleAttributed:(NSDictionary *)att ofRange:(NSRange)range{
    NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:self.text];
    [matt addAttributes:att range:range];
    self.attributedText = matt;
}
//异步获取Label的图片
-(void)w_httpLabelLeftImage:(NSString *)imgUrl label:(UILabel *)label imageX:(CGFloat)imageX imageY:(CGFloat)imageY imageH:(CGFloat)imageH atIndex:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        UIImage *img = nil;
        if ([imgUrl hasPrefix:@"http"]) {
            img =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        } else {
            img =  [UIImage imageNamed:imgUrl];
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [label w_addAttchmentImage:img andBounds:CGRectMake(imageX, imageY, imageH*img.size.width/img.size.height, imageH) atIndex:index];
        });
    });
}

@end
