//
//  NSDate+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "NSDate+WExtension.h"

@implementation NSDate(WExtension)

+(NSString*)w_convertToDateWithTimetamp:(NSString*)tamp format:(NSString*)format{
    if (tamp.length == 0) {
        return @"";
    }
    NSDate          *date = [NSDate dateWithTimeIntervalSince1970:tamp.doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return   [formatter stringFromDate:date];
}
+ (NSString *)w_dateHandle:(long)dateTime
{
    long    aDayTime = 24 * 60 * 60;
    long    diff = [[NSDate date] timeIntervalSince1970] - dateTime;
    
    NSDate          *date = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    if (diff < aDayTime) {                                          // 今天
        format.dateFormat = @"今天 HH:mm";
    } else if ((diff >= aDayTime) && (diff < aDayTime * 2)) {       // 昨天
        format.dateFormat = @"昨天 HH:mm";
    } else if ((diff >= aDayTime * 2) && (diff < aDayTime * 3)) {   // 前天
        format.dateFormat = @"前天 HH:mm";
    } else {
        format.dateFormat = @"MM-dd HH:mm";
    }
    return [format stringFromDate:date];
}
@end
