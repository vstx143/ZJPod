//
//  WZJBaseCollectionViewController.h
//  WZJBaseViewController
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZJBaseViewControllerConfig.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
NS_ASSUME_NONNULL_BEGIN

@interface WZJBaseCollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BaseRefreshDelegate>
@property(nonatomic,strong) UICollectionView *w_collectionView;
@property(nonatomic,assign) int currentPage;
@property(nonatomic,weak) id<BaseRefreshDelegate> refreshDelegate;
-(void)addRefreshFunction:(WRefreshType) refreshType;
-(void)startRequest;

@end

NS_ASSUME_NONNULL_END
