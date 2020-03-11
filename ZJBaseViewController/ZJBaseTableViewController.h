//
//  ZJBaseTableViewController.h
//  ZJBaseViewController
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseViewControllerConfig.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,BaseRefreshDelegate>
@property(nonatomic,strong) UITableView *w_tableView;
@property(nonatomic,assign) int currentPage;
@property(nonatomic,assign) BOOL w_showEmpty;
@property(nonatomic,weak) id<BaseRefreshDelegate> refreshDelegate;
-(void)addRefreshFunction:(WRefreshType) refreshType;
-(void)startRequest;
@end


NS_ASSUME_NONNULL_END
