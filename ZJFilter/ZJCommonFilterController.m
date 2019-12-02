//
//  ZJCommonFilterController.m
//  YLGrid
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ZJCommonFilterController.h"
#import "ZJCommonFilterModel.h"
#import "ZJCommonFilterTopView.h"
#import <Masonry/Masonry.h>
#import "UIViewController+PresentBottom.h"
#import "ZJBaseConstant.h"
@interface ZJCommonFilterController ()

@property(nonatomic,strong) ZJCommonFilterTopView *topView;
@property(nonatomic,assign) id<ZJCommonFilterControllerDataSource> dataSource;
@property(nonatomic,strong) NSArray *items;
@property(nonatomic,strong) NSArray *selelctedItems;
@end

@implementation ZJCommonFilterController
+(instancetype)filterCommonControllerWithItems:(NSArray<ZJCommonFilterModel*>*)items selectedItems:(NSArray<ZJCommonFilterModel*>*)selectedItems dataSource:(id<ZJCommonFilterControllerDataSource>) dataSource{
    ZJCommonFilterController *controller = [[self alloc]init];
    controller.items = [items copy];
    controller.selelctedItems = [selectedItems copy];
    controller.dataSource = dataSource;
    return controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.dataSource respondsToSelector:@selector(ZJ_TopView)]) {
        _topView = [self.dataSource ZJ_TopView] == nil ? self.topView:[self.dataSource ZJ_TopView];
    }else{
        _topView = self.topView;
    }
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo([self.dataSource ZJ_TopViewHeight]).priorityHigh();
    }];
    [self.w_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.w_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.w_tableView.bounces = NO;
    self.w_tableView.backgroundColor = UIColor.whiteColor;
    self.w_tableView.separatorInset = UIEdgeInsetsZero;
    [self.dataSource ZJ_TableViewRegisterCell:self.w_tableView];
    //
    [self initSelectedItems];
}
-(void)initSelectedItems{
    for (ZJCommonFilterModel *item in self.items) {
        for (ZJCommonFilterModel *selectedItem in self.selelctedItems) {
            if ([item.ID isEqualToString:selectedItem.ID]) {
                item.isSelected = YES;
            }
        }
    }
    [self.w_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource ZJ_TableView:tableView heightForRowAtIndexPath:indexPath];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource ZJ_TableView:tableView cellOfRow:indexPath itemModel:self.items[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJCommonFilterModel *item = self.items[indexPath.row];
    //
    if (self.isSingle) {
        [self clearFilter];
        //
        item.isSelected = !item.isSelected;
        //
        [self sureAction];
    }else{
        item.isSelected = !item.isSelected;
    }
    [self.w_tableView reloadData];
}

#pragma mark -- action
-(NSString*)filterSelected{
    NSString *lstr = @"";
    for (ZJCommonFilterModel *item in self.items) {
        if (item.isSelected) {
            if (lstr.length > 0) {
                lstr = [NSString stringWithFormat:@"%@..",lstr];
                break;
            } else {
                lstr = item.name;
            }
        }
    }
    return lstr;
}
-(NSArray*)filterSelectedItems{
    NSMutableArray *lary = [NSMutableArray array];
    for (ZJCommonFilterModel *item in self.items) {
        if (item.isSelected) {
            [lary addObject:item];
        }
    }
    return [lary copy];
}
-(void)clearFilter{
    for (ZJCommonFilterModel *item in self.items) {
        item.isSelected = NO;
    }
    [self.w_tableView reloadData];
}
-(void)sureAction{
    if (self.isMustSelected && [self filterSelectedItems].count == 0) {
        if ([self.delegate respondsToSelector:@selector(mustSelectTip)]) {
            [self.delegate mustSelectTip];
        }
        return;
    }
    if (self.ClickFilterBlock) {
        self.ClickFilterBlock([self filterSelected], [self filterSelectedItems]);
    }
    [self w_dismissBottomVC];
}
-(ZJCommonFilterTopView*)topView{
    if (!_topView) {
        _topView = [ZJCommonFilterTopView new];
        @WWeakify(self);
        _topView.ClickSureBlock = ^{
            @WStrongify(self);
            [self sureAction];
        };
        _topView.ClickCancelBlock = ^{
            @WStrongify(self);
            [self w_dismissBottomVC];
        };
    }
    return _topView;
}
-(void)dealloc{
    NSLog(@"~~~~~~~%@",[self class]);
}
@end
