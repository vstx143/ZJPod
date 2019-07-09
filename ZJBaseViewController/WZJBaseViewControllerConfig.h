//
//  WZJBaseViewControllerConfig.h
//  Logistic
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 TongRuan. All rights reserved.
//

#ifndef WZJBaseViewControllerConfig_h
#define WZJBaseViewControllerConfig_h

typedef NS_ENUM(NSInteger,WRefreshType) {
    WRefreshTypeNone=0,
    WRefreshTypePullDown = 1,
    WRefreshTypePullUp = 2,
    WRefreshTypeAll = 3
};

typedef void (^LoadEndCallBack)(int state);

@protocol BaseRefreshDelegate <NSObject>
-(void)pullDownRefresh:(LoadEndCallBack)callBack;
-(void)pullUpLoadMore:(LoadEndCallBack)callBack;
@end

@protocol BaseCellConfig<NSObject>
-(void)configCell:(id)cellItem;
@end

#import "WZJBaseCollectionViewController.h"
#import "WZJBaseTableViewController.h"
#import "WZJBaseViewController.h"
#endif /* WZJBaseViewControllerConfig_h */
