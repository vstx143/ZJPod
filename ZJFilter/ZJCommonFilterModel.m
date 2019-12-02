//
//  ZJCommonFilterModel.m
//  YLGrid
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ZJCommonFilterModel.h"

@implementation ZJCommonFilterModel
inline ZJCommonFilterModel *ZJ_CreateCommonFilterModel(NSString* ID,NSString *name,BOOL isSelected){
    ZJCommonFilterModel *item = [ZJCommonFilterModel new];
    item.ID = ID;
    item.name = name;
    item.isSelected = isSelected;
    return item;
}
@end


