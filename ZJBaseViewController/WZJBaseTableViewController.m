//
//  WZJBaseTableViewController.m
//  WZJBaseViewController
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "WZJBaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface WZJBaseTableViewController ()
@property(assign)WRefreshType type;
@end

@implementation WZJBaseTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.navigationBar.hidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    self.w_tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.w_tableView.showsVerticalScrollIndicator = NO;
    self.w_tableView.showsHorizontalScrollIndicator = NO;
    self.w_tableView.delegate = self;
    self.w_tableView.dataSource = self;
    self.w_tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.w_tableView];

    if (@available(iOS 11.0, *)) {
        self.w_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.w_tableView.emptyDataSetSource = self;
    self.w_tableView.emptyDataSetDelegate = self;
    //
    self.currentPage = 1;
    self.refreshDelegate = self;
}
#pragma mark --空数据
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc]initWithString:@"暂无数据" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:UIColor.darkGrayColor}];
}

#pragma mark --- table delegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(void)startRequest{
    if (self.type == WRefreshTypeAll || self.type == WRefreshTypePullDown) {
        [self.w_tableView.mj_header beginRefreshing];
    }else{
        [self.w_tableView.mj_footer beginRefreshing];
    }
}
#pragma mark --- r刷新状态
-(void)pullUpLoadMore:(LoadEndCallBack)callBack{}
-(void)pullDownRefresh:(LoadEndCallBack)callBack{}
-(void)addRefreshFunction:(WRefreshType) refreshType{
    //
    self.type = refreshType;
    //
    __weak typeof(&*self)weakSelf = self;
    switch (refreshType) {
        case WRefreshTypeAll:
        {
            self.w_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullDownRefresh:)]) {
                    [weakSelf.refreshDelegate pullDownRefresh:^(int state) {
                            [weakSelf.w_tableView.mj_header endRefreshing];
                        if (weakSelf.w_tableView.mj_footer != nil && state ==MJRefreshStateNoMoreData ) {
                            [weakSelf.w_tableView.mj_footer endRefreshingWithNoMoreData];
                        }
                    }];
                }
                if (weakSelf.w_tableView.mj_footer != nil) {
                    [weakSelf.w_tableView.mj_footer resetNoMoreData];
                }
            }];
            
            self.w_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullUpLoadMore:)]) {
                    [weakSelf.refreshDelegate pullUpLoadMore:^(int state) {
                        if (state == MJRefreshStateNoMoreData) {
                            [weakSelf.w_tableView.mj_footer endRefreshingWithNoMoreData];
                        } else {
                            [weakSelf.w_tableView.mj_footer endRefreshing];
                        }
                    }];
                }
            }];
        }
            break;
        case WRefreshTypePullUp:{
            self.w_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullUpLoadMore:)]) {
                    [weakSelf.refreshDelegate pullUpLoadMore:^(int state) {
                        if (state == MJRefreshStateNoMoreData) {
                            [weakSelf.w_tableView.mj_footer endRefreshingWithNoMoreData];
                        } else {
                            [weakSelf.w_tableView.mj_footer endRefreshing];
                        }
                    }];
                }
            }];
        }
            break;
        case WRefreshTypePullDown:{
            self.w_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullDownRefresh:)]) {
                    [weakSelf.refreshDelegate pullDownRefresh:^(int state) {
                        [weakSelf.w_tableView.mj_header endRefreshing];
                    }];
                }
            }];
        }
            break;
        default:
            break;
    }
}
-(void)dealloc{
    
}

@end
