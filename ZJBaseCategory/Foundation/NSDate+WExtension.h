//
//  NSDate+WExtension.h
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(WExtension)
+(NSString*)w_convertToDateWithTimetamp:(NSString*)tamp format:(NSString*)format;
/**
 *  时间处理
 *
 *  @param dateTime 时间戳
 *
 *  @return 格式化的时间
 */
+ (NSString*)w_dateHandle:(long)dateTime;
@end

NS_ASSUME_NONNULL_END
