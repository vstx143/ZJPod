//
//  WZJBaseCollectionViewController.m
//  WZJBaseViewController
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "WZJBaseCollectionViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface WZJBaseCollectionViewController ()
@property(assign)WRefreshType type;
@end

@implementation WZJBaseCollectionViewController
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
    if (self.type == WRefreshTypeAll || self.type == WRefreshTypePullDown) {
        [self.w_collectionView.mj_header beginRefreshing];
    }else{
        [self.w_collectionView.mj_footer beginRefreshing];
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
            self.w_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshDelegate && [weakSelf respondsToSelector:@selector(pullDownRefresh:)]) {
                    [weakSelf.refreshDelegate pullDownRefresh:^(int state) {
                        [weakSelf.w_collectionView.mj_header endRefreshing];
                        if (weakSelf.w_collectionView.mj_footer != nil && state ==MJRefreshStateNoMoreData ) {
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
                    [weakSelf.refreshDelegate pullUpLoadMore:^(int state) {
                        if (state == MJRefreshStateNoMoreData) {
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
                    [weakSelf.refreshDelegate pullUpLoadMore:^(int state) {
                        if (state == MJRefreshStateNoMoreData) {
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
                    [weakSelf.refreshDelegate pullDownRefresh:^(int state) {
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
