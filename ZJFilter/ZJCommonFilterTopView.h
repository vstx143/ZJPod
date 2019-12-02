//
//  ZJCommonFilterTopView.h
//  YLGrid
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJCommonFilterTopView : UIView

@property(nonatomic,copy) void (^ClickCancelBlock)(void);
@property(nonatomic,copy) void (^ClickSureBlock)(void);

@property(nonatomic,strong,readonly) UIView *titleView;

@property(nonatomic,strong) UIColor *leftColor;
@property(nonatomic,strong) UIColor *rightColor;
@property(nonatomic,strong) UIFont  *btnFont;
@property(nonatomic,strong) UIColor *backColor;
@property(nonatomic,strong) UIColor *bottomLineColor;
@end

NS_ASSUME_NONNULL_END
