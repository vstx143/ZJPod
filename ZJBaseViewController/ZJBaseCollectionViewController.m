//
//  ZJBaseCollectionViewController.m
//  ZJBaseViewController
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZJBaseCollectionViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface ZJBaseCollectionViewController ()
@property(assign)WRefreshType wtype;
@end

@implementation ZJBaseCollectionViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.w_collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.w_collectionView.showsHorizontalScrollIndicator = NO;
    self.w_collectionView.showsVerticalScrollIndicator = NO;
    self.w_collectionView.dataSource = self;
    self.w_collectionView.delegate = self;
    [self.view addSubview:self.w_collectionView];
    
    if (@available(iOS 11.0, *)) {
        self.w_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.currentPage = 1;
    self.refreshDelegate =self;
}
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeZero;
}
-(void)startRequest{
    if (self.wtype == WRefreshTypeAll || self.wtype == WRefreshTypePullDown) {
        [self.w_collectionView.mj_header beginRefreshing];
    }else{
        [self.w_collectionView.mj_footer beginRefreshing];
    }
}
#pragma mark --- r刷新状态
-(void)pullUpLoadMore:(LoadEndCallBack)callBack{}
-(void)pullDownRefresh:(LoadEndCallBack)callBack{}

-(MJRefreshState)covertRefreshStateWithLoadState:(ZJLoadState)state{
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
            self.w_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullDownRefresh:)]) {
                    [weakSelf.refreshDelegate pullDownRefresh:^(ZJLoadState state) {
                        [weakSelf.w_collectionView.mj_header endRefreshing];
                        if (weakSelf.w_collectionView.mj_footer != nil && [weakSelf covertRefreshStateWithLoadState:state] ==MJRefreshStateNoMoreData ) {
                            [weakSelf.w_collectionView.mj_footer endRefreshingWithNoMoreData];
                        }
                    }];
                }
                if (weakSelf.w_collectionView.mj_footer != nil) {
                    [weakSelf.w_collectionView.mj_footer resetNoMoreData];
                }
            }];
            
            self.w_collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullUpLoadMore:)]) {
                    [weakSelf.refreshDelegate pullUpLoadMore:^(ZJLoadState state) {
                        if ([weakSelf covertRefreshStateWithLoadState:state] == MJRefreshStateNoMoreData) {
                            [weakSelf.w_collectionView.mj_footer endRefreshingWithNoMoreData];
                        } else {
                            [weakSelf.w_collectionView.mj_footer endRefreshing];
                        }
                    }];
                }
            }];
        }
            break;
        case WRefreshTypePullUp:{
            self.w_collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullUpLoadMore:)]) {
                    [weakSelf.refreshDelegate pullUpLoadMore:^(ZJLoadState state) {
                        if ([weakSelf covertRefreshStateWithLoadState:state] == MJRefreshStateNoMoreData) {
                            [weakSelf.w_collectionView.mj_footer endRefreshingWithNoMoreData];
                        } else {
                            [weakSelf.w_collectionView.mj_footer endRefreshing];
                        }
                    }];
                }
            }];
        }
            break;
        case WRefreshTypePullDown:{
            self.w_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullDownRefresh:)]) {
                    [weakSelf.refreshDelegate pullDownRefresh:^(ZJLoadState state) {
                        [weakSelf.w_collectionView.mj_header endRefreshing];
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
