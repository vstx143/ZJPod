//
//  ZJControllerRouter.m
//  Logistic
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#import "ZJControllerRouter.h"

@implementation ZJControllerRouter
#pragma mark -- push
+(void)pushTarget:(NSString*)className nav:(UINavigationController*)navController{
      [self pushTarget:className title:@"" isInitXib:NO  action:@""  params:@"" nav:navController];
}
+(void)pushTarget:(NSString*)className
          title:(NSString*)title
            nav:(UINavigationController*)navController{
        [self pushTarget:className title:title isInitXib:NO  action:@""  params:@"" nav:navController];
}
+(void)pushTarget:(NSString*)className
         action:(NSString*)action
         params:(_Nullable id)params
            nav:(UINavigationController*)navController{
        [self pushTarget:className title:@"" isInitXib:NO  action:action  params:params nav:navController];
}
+(void)pushTarget:(NSString*)className
          title:(NSString*)title
         action:(NSString*)action
         params:(_Nullable id)params
            nav:(UINavigationController*)navController{
     [self pushTarget:className title:title isInitXib:NO  action:action  params:params nav:navController];
}
+(void)pushTarget:(NSString*)className
         action:(NSString*)action
         params:(_Nullable id)params
   handleAction:(NSString* _Nullable)handleAction
    handleBlock:(void(^ __nullable)(id blockParams))handleBlock
            nav:(UINavigationController*)navController{
     [self pushTarget:className title:@"" isInitXib:NO action:action params:params handleAction:handleAction handleBlock:handleBlock nav:navController];
}
+(void)pushTarget:(NSString*)className
          title:(NSString* _Nullable )title
      isInitXib:(BOOL)isXib
         action:(NSString*)action
         params:(_Nullable id)params
            nav:(UINavigationController*)navController{
    [self pushTarget:className title:title isInitXib:isXib action:action params:params handleAction:nil handleBlock:nil nav:navController];
}
+(void)pushTarget:(NSString*)className
          title:(NSString* _Nullable )title
      isInitXib:(BOOL)isXib
         action:(NSString*)action
         params:(_Nullable id)params
   handleAction:(NSString* _Nullable)handleAction
    handleBlock:(void(^ __nullable)(id blockParams))handleBlock
            nav:(UINavigationController*)navController{
    if (className.length == 0) {
        return;
    }
    NSAssert([params isKindOfClass:[NSObject class]], @"参数需要NSObject对象");
    
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = nil;
        if (isXib) {
            vc = [(UIViewController*)[class alloc] initWithNibName:className bundle:nil];
        } else {
            vc = [class new];
        }
        if ([vc respondsToSelector:NSSelectorFromString(action)]) {
            [vc performSelector:NSSelectorFromString(action) withObject:params];
        }
        if ([vc respondsToSelector:NSSelectorFromString(handleAction)]) {
            [vc performSelector:NSSelectorFromString(handleAction) withObject:handleBlock];
        }
        if (title != nil) {
            vc.title = title;
        }
        
        [navController pushViewController:vc animated:YES];
    }
}
#pragma mark -- present
+(void)presentTarget:(NSString*)className
            action:(NSString*)action
            params:(_Nullable id)params{
    [self presentTarget:className isInitXib:NO action:action params:params handleAction:@"" handleBlock:nil];
}
+(void)presentTarget:(NSString*)className
            action:(NSString*)action
            params:(_Nullable id)params
      handleAction:(NSString* _Nullable)handleAction
       handleBlock:( void(^ __nullable)(id blockParams))handleBlock{
     [self presentTarget:className isInitXib:NO action:action params:params handleAction:handleAction handleBlock:handleBlock];
}
+(void)presentTarget:(NSString*)className
         isInitXib:(BOOL)isXib
            action:(NSString*)action
            params:(_Nullable id)params
      handleAction:(NSString* _Nullable)handleAction
       handleBlock:(void(^ __nullable)(id blockParams))handleBlock{
    if (className.length == 0) {
        return;
    }
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = nil;
        if (isXib) {
            vc = [(UIViewController*)[class alloc] initWithNibName:className bundle:nil];
        } else {
            vc = [class new];
        }
        //
        if ([vc respondsToSelector:NSSelectorFromString(action)]) {
            [vc performSelector:NSSelectorFromString(action) withObject:params];
        }
        //
        if ([vc respondsToSelector:NSSelectorFromString(handleAction)]) {
            [vc performSelector:NSSelectorFromString(handleAction) withObject:handleBlock];
        }
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}
@end
