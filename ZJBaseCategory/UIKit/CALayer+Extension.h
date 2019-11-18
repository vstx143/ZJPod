//
//  CALayer+Extension.h
//  Logistic
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,KGradualColorStyle){
    KGradualColorStyleLTBR = 0, //左上->右下
    KGradualColorStyleTB =1 //上->下
};

@interface CALayer(Extension)
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr style:(KGradualColorStyle)style;
@end

NS_ASSUME_NONNULL_END
