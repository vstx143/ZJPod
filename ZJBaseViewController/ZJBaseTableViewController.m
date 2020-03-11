//
//  ZJBaseTableViewController.m
//  ZJBaseViewController
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZJBaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface ZJBaseTableViewController ()
@property(assign)WRefreshType wtype;
@end

@implementation ZJBaseTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
#ifdef DEBUG
    NSLog(@"~~~ZJPod~~~%@~~~~%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
}
- (void)dealloc{
#ifdef DEBUG
    NSLog(@"~~~ZJPod~~~%@~~~~%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
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
    //
    self.currentPage = 1;
    self.refreshDelegate = self;
    //
    self.w_showEmpty = YES;
}
#pragma mark --- 空数据展示页面
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc]initWithString:@"暂无数据，点击刷新" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self startRequest];
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
    if (self.wtype == WRefreshTypeAll || self.wtype == WRefreshTypePullDown) {
        [self.w_tableView.mj_header beginRefreshing];
    }else{
        [self.w_tableView.mj_footer beginRefreshing];
    }
}
#pragma mark --- r刷新状态
-(void)pullUpLoadMore:(LoadEndCallBack)callBack{}
-(void)pullDownRefresh:(LoadEndCallBack)callBack{}

-(MJRefreshState)covertRefreshStateWithLoadState:(ZJLoadState)state{
    if (self.w_showEmpty) {
        self.w_tableView.emptyDataSetSource = self;
        self.w_tableView.emptyDataSetDelegate = self;
    }
    MJRefreshState lstate = MJRefreshStateIdle;
    switch (state) {
        case ZJLoadStateIdle:
            lstate =MJRefreshStateIdle;
            break;
        case ZJLoadStatePulling:
            lstate =MJRefreshStatePulling;
            break;
        case ZJLoadStateRefreshing:
            lstate =MJRefreshStateRefreshing;
            break;
        case ZJLoadStateWillRefresh:
            lstate =MJRefreshStateWillRefresh;
            break;
        case ZJLoadStateNoMoreData:
            lstate =MJRefreshStateNoMoreData;
            break;
            
        default:
            break;
    }
    return lstate;
}

-(void)addRefreshFunction:(WRefreshType) refreshType{
    //
    self.wtype = refreshType;
    //
    __weak typeof(&*self)weakSelf = self;
    switch (refreshType) {
        case WRefreshTypeAll:
        {
            self.w_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullDownRefresh:)]) {
                    [weakSelf.refreshDelegate pullDownRefresh:^(ZJLoadState state) {
                            [weakSelf.w_tableView.mj_header endRefreshing];
                        if (weakSelf.w_tableView.mj_footer != nil && [weakSelf covertRefreshStateWithLoadState:state] ==MJRefreshStateNoMoreData ) {
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
                    [weakSelf.refreshDelegate pullUpLoadMore:^(ZJLoadState state) {
                        if ([weakSelf covertRefreshStateWithLoadState:state] == MJRefreshStateNoMoreData) {
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
                    [weakSelf.refreshDelegate pullUpLoadMore:^(ZJLoadState state) {
                        if ([weakSelf covertRefreshStateWithLoadState:state] == MJRefreshStateNoMoreData) {
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
                    [weakSelf.refreshDelegate pullDownRefresh:^(ZJLoadState state) {
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

@end
