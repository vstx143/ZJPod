//
//  ZJBaseConstant.h
//  Logistic
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#ifndef ZJBaseConstant_h
#define ZJBaseConstant_h

//屏幕尺寸
#define WScreenBounds [[UIScreen mainScreen] bounds]

#define WScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define WScreenWidth ([[UIScreen mainScreen] bounds].size.width)
//是否是iphoneX
#define WIsHponeX ({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
//状态栏和tabbar高度
#define WNavBarHEIGHT (WIsHponeX == YES ? 88.0 : 64.0)
#define WTabBarHEIGHT (WIsHponeX == YES ? 83.0 : 49.0)
#define WStatusBarHEIGHT (WIsHponeX == YES ? 44.0 : 20.0)
//放大倍数
#define WKScaleX (WScreenWidth / 375.0)
#define WKScaleY (WScreenHeight / 667.0)
//解除循环引用
#define WWeakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#define WStrongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#define WeakSelf(weakSelf)  __weak typeof(&*self)weakSelf = self;
//字体
#define WFontMedium_x(x)   [UIFont systemFontOfSize:x weight:UIFontWeightMedium]
#define WFont_x(x)  [UIFont systemFontOfSize:x]
//颜色
#define WRGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#endif /* LSConstantConfig_h */
