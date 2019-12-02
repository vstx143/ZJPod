//
//  ZJCommonFilterTopView.m
//  YLGrid
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ZJCommonFilterTopView.h"
#import <Masonry/Masonry.h>
@implementation ZJCommonFilterTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = self.backColor == nil ? UIColor.whiteColor:self.backColor;
        UIButton *cancelBtn = [UIButton w_buttonWithTitle:@"取消" titleColor:self.leftColor == nil ? UIColor.grayColor:self.leftColor font:self.btnFont == nil?WFont_x(16):self.btnFont  target:self action:@selector(btnAction:)];
        cancelBtn.tag =0;
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        //
        UIButton *sureBtn = [UIButton w_buttonWithTitle:@"确定" titleColor:self.rightColor == nil ? UIColor.blueColor:self.rightColor font:self.btnFont == nil?WFont_x(16):self.btnFont target:self action:@selector(btnAction:)];
        [self addSubview:sureBtn];
        sureBtn.tag = 2;
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(cancelBtn.mas_width);
        }];
        //
        _titleView = [UIView new];
        [self addSubview:_titleView];
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(cancelBtn.mas_right);
            make.right.mas_equalTo(sureBtn.mas_left);
        }];
        //
        UIView *bottomLineView = [UIView new];
        bottomLineView.backgroundColor = self.bottomLineColor == nil ? UIColor.lightGrayColor:self.bottomLineColor;
        [self addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}
-(void)btnAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 0:
            if (self.ClickCancelBlock) {
                self.ClickCancelBlock();
            }
            break;
        case 2:
            if (self.ClickSureBlock) {
                self.ClickSureBlock();
            }
            break;
            
        default:
            break;
    }
}

@end
