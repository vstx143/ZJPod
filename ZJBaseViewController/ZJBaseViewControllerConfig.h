//
//  ZJBaseViewControllerConfig.h
//  Logistic
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#ifndef ZJBaseViewControllerConfig_h
#define ZJBaseViewControllerConfig_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,WRefreshType) {
    WRefreshTypeNone=0,
    WRefreshTypePullDown = 1,
    WRefreshTypePullUp = 2,
    WRefreshTypeAll = 3
};

typedef NS_ENUM(NSInteger,ZJLoadState){
    /** 普通闲置状态 */
    ZJLoadStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    ZJLoadStatePulling,
    /** 正在刷新中的状态 */
    ZJLoadStateRefreshing,
    /** 即将刷新的状态 */
    ZJLoadStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    ZJLoadStateNoMoreData
};

typedef void (^LoadEndCallBack)(ZJLoadState state);

@protocol BaseRefreshDelegate <NSObject>
-(void)pullDownRefresh:(LoadEndCallBack)callBack;
-(void)pullUpLoadMore:(LoadEndCallBack)callBack;
@end

@protocol BaseCellConfig<NSObject>
-(void)configCell:(id)cellItem;
@end

#import "ZJBaseCollectionViewController.h"
#import "ZJBaseTableViewController.h"
#endif /* ZJBaseViewControllerConfig_h */
