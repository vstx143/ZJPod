//
//  ZJBaseViewControllerConfig.h
//  Logistic
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#ifndef ZJBaseViewControllerConfig_h
#define ZJBaseViewControllerConfig_h

typedef NS_ENUM(NSInteger,WRefreshType) {
    WRefreshTypeNone=0,
    WRefreshTypePullDown = 1,
    WRefreshTypePullUp = 2,
    WRefreshTypeAll = 3
};

typedef void (^LoadEndCallBack)(MJRefreshState state);

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
