//
//  WZJControllerRouter.h
//  Logistic
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WZJControllerRouter : NSObject
#pragma mark -- push不回调
/**
 push 不传参数的类
 @param className 类名
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className nav:(UINavigationController*)navController;
/**
 push 有标题的类
 
 @param className 类名
 @param title 标题
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className
          title:(NSString*)title
            nav:(UINavigationController*)navController;

/**
 push 无标题带参数
 
 @param className 类名
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className
         action:(NSString*)action
         params:(_Nullable id)params
            nav:(UINavigationController*)navController;

/**
 push 标题带参数
 
 @param className 类名
 @param title 标题
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className
          title:(NSString*)title
         action:(NSString*)action
         params:(_Nullable id)params
            nav:(UINavigationController*)navController;


/**
 push xib标题带参数
 
 @param className 类名
 @param title 标题
 @param isXib 是否用xib初始化类，默认 NO
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className
          title:(NSString* _Nullable )title
      isInitXib:(BOOL)isXib
         action:(NSString*)action
         params:(_Nullable id)params
            nav:(UINavigationController*)navController;
/**
 push xib标题带参数
 
 @param className 类名
 @param title 标题
 @param isXib 是否用xib初始化类，默认 NO
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param handleAction 回调方法名（注意带参数是，方法的冒号（methon：））
 @param handleBlock  回调Block
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className
          title:(NSString* _Nullable )title
      isInitXib:(BOOL)isXib
         action:(NSString*)action
         params:(_Nullable id)params
   handleAction:(NSString* _Nullable)handleAction
    handleBlock:(void(^ __nullable)(id blockParams))handleBlock
            nav:(UINavigationController*)navController;
#pragma mark -- 有回调
/**
 push 无标题带参数、带回调
 
 @param className 类名
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param handleAction 回调方法名（注意带参数是，方法的冒号（methon：））
 @param handleBlock  回调Block
 @param navController 导航类
 */
+(void)pushTarget:(NSString*)className
         action:(NSString*)action
         params:(_Nullable id)params
   handleAction:(NSString* _Nullable)handleAction
    handleBlock:(void(^ __nullable)(id blockParams))handleBlock
            nav:(UINavigationController*)navController;

#pragma mark -- present
/**
 present 从rootViewController present
 @param className 类名
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 */
+(void)presentTarget:(NSString*)className
            action:(NSString*)action
            params:(_Nullable id)params;

/**
 present 从rootViewController present
 
 @param className 类名
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param handleAction 给类赋值block
 @param handleBlock block回传参数
 */
+(void)presentTarget:(NSString*)className
            action:(NSString*)action
            params:(_Nullable id)params
      handleAction:(NSString* _Nullable)handleAction
       handleBlock:(void(^ __nullable)(id blockParams))handleBlock;

/**
 present 从rootViewController present

 @param className 类名
 @param isXib 是否用xib初始化类，默认 NO
 @param action 方法名（注意带参数是，方法的冒号（methon：））
 @param params 参数（NSObject）对象
 @param handleAction 给类赋值block
 @param handleBlock block回传参数
 */
+(void)presentTarget:(NSString*)className
         isInitXib:(BOOL)isXib
            action:(NSString*)action
            params:(_Nullable id)params
      handleAction:( NSString* _Nullable )handleAction
       handleBlock:(void(^ __nullable)(id blockParams))handleBlock;

@end

NS_ASSUME_NONNULL_END
