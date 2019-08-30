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
#define WNavBarHeight (WIsHponeX == YES ? 88.0 : 64.0)
#define WTabBarHeight (WIsHponeX == YES ? 83.0 : 49.0)
#define WStatusBarHeight (WIsHponeX == YES ? 44.0 : 20.0)
//放大倍数
#define WScaleX (WScreenWidth / 375.0)
#define WScaleY (WScreenHeight / 667.0)
//解除循环引用
#define WWeakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#define WStrongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#define WeakSelf(weakSelf)  __weak typeof(&*self)weakSelf = self;
//字体
#define WFontMedium_x(x)   [UIFont systemFontOfSize:x weight:UIFontWeightMedium]
#define WFont_x(x)  [UIFont systemFontOfSize:x]
//颜色
#define WRGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//
#pragma mark --- 复制yykit添加属性
#ifndef WRuntimeAddPropertyObject
/**
 添加object属性
 
 @param _getter_ (getXXXX)
 @param _setter_ (setXXXX)
 @param _association_  (ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC)
 @param _type_ (NSObject *)
 @return NSObject数据类型
 */
#define WRuntimeAddPropertyObject(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif
#ifndef WRuntimeAddPropertyC
/**
 添加C属性
 
 @param _getter_ (setXXX)
 @param _setter_ (getXXX)
 @param _type_ (c数据类型)
 @return c数据类型
 */
#define WRuntimeAddPropertyC(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
_type_ cValue = { 0 }; \
NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
[value getValue:&cValue]; \
return cValue; \
}
#endif

#pragma mark -- 方法替换
//
#ifndef WRuntimeExchangeMethod
/**
 方法替换
 @param target  实例对象
 @param originalMethod (@selector(xxxx))
 @param newMethod (@selector(xxxx))
 */
#define WRuntimeExchangeMethod(target,originalMethod, newMethod) \
{ \
Method originalM = class_getInstanceMethod([target class], originalMethod); \
Method newM = class_getInstanceMethod([target class], newMethod); \
method_exchangeImplementations(originalM, newM); \
}
#endif

#endif /* LSConstantConfig_h */
