//
//  UIView+WExtension.h
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum: NSUInteger{
    LineDirectionTop,
    LineDirectionBottom,
    LineDirectionMiddel,
}LineDirection;
@interface UIView(WExtension_Touch)
//xib初始化
+ (instancetype)w_loadViewWithXib;
//增加点击事件
typedef void (^TouchBlock)(void);
typedef void (^TouchBlockWithObject)(id obj);
-(void)w_addJXTouch:(TouchBlock)block;
-(void)w_addJXTouchWithObject:(TouchBlockWithObject)block;
- (void)w_addTarget:(id)target action:(SEL)action;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)w_isShowingOnKeyWindow;
/**
 添加内边线或中线
 
 @param direction 方向
 @param size 尺寸
 */
- (void)w_addLineOnDirection:(LineDirection)direction color:(UIColor*)color withLineSzie:(CGSize)size;
@end

@interface UIView(WExtension_Frame)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) UIView *topSuperView;

- (void)w_widthEqualToView:(UIView *)view;
- (void)w_heightEqualToView:(UIView *)view;
- (void)w_sizeEqualToView:(UIView *)view;
- (void)w_centerXEqualToView:(UIView *)view;
- (void)w_centerYEqualToView:(UIView *)view;
- (void)w_top:(CGFloat)top fromView:(UIView *)view;
- (void)w_bottom:(CGFloat)bottom fromView:(UIView *)view;
- (void)w_left:(CGFloat)left fromView:(UIView *)view;
- (void)w_right:(CGFloat)right fromView:(UIView *)view;
- (void)w_fillWidth;
- (void)w_fillHeight;
- (void)w_fill;
- (void)w_removeAllSubviews;
- (void)w_hideSubView;
- (void)w_showSubView;
- (void)w_shake;
@end

@interface UIView(WExtension_Layer)
//设置边线
/// 边线颜色
@property (nonatomic, strong) UIColor *borderColor;
/// 边线宽度
@property (nonatomic, assign) CGFloat borderWidth;
/// 脚半径
@property (nonatomic, assign) CGFloat cornerRadius;
@end
NS_ASSUME_NONNULL_END
