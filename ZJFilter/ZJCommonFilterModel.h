//
//  ZJCommonFilterModel.h
//  YLGrid
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJCommonFilterModel : NSObject
@property(nonatomic,copy) NSString* ID;
@property(nonatomic,copy) NSString* name;
//
@property(assign) BOOL isSelected;

FOUNDATION_EXPORT ZJCommonFilterModel *ZJ_CreateCommonFilterModel(NSString* ID,NSString *name,BOOL isSelected);
@end

NS_ASSUME_NONNULL_END

