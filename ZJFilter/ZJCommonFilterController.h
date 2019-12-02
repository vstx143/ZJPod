//
//  ZJCommonFilterController.h
//  YLGrid
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ZJBaseTableViewController.h"

@class ZJCommonFilterModel,ZJCommonFilterTopView;

@protocol ZJCommonFilterControllerDataSource <NSObject>
@required;
-(void)ZJ_TableViewRegisterCell:(UITableView*_Nullable)tableView;
-(UITableViewCell*_Nullable)ZJ_TableView:(UITableView*_Nullable)tableView cellOfRow:(NSIndexPath*_Nullable)indexPath itemModel:(ZJCommonFilterModel*_Nullable)item;
-(CGFloat)ZJ_TableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
-(CGFloat)ZJ_TopViewHeight;

@optional
-(ZJCommonFilterTopView*_Nullable)ZJ_TopView;

@end
NS_ASSUME_NONNULL_BEGIN

@interface ZJCommonFilterController : ZJBaseTableViewController
@property(nonatomic,copy) void (^ClickFilterBlock)(NSString *title,id values);
+(instancetype)filterCommonControllerWithItems:(NSArray<ZJCommonFilterModel*>*)items selectedItems:(NSArray<ZJCommonFilterModel*>*)selectedItems dataSource:(id<ZJCommonFilterControllerDataSource>) dataSource;
//
@property(nonatomic,assign) BOOL isSingle;
@property(nonatomic,assign) BOOL isMustSelected;
@end

NS_ASSUME_NONNULL_END
