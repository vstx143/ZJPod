//
//  NSDecimalNumber+Extention.h
//  CartTest
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber(Extention)
//加、减、乘、除
FOUNDATION_EXPORT NSDecimalNumber *w_add(NSString *oneStr,NSString *twoStr);
FOUNDATION_EXPORT NSDecimalNumber *w_subtracting(NSString *oneStr,NSString *twoStr);
FOUNDATION_EXPORT NSDecimalNumber *w_multiplying(NSString *oneStr,NSString *twoStr);
FOUNDATION_EXPORT NSDecimalNumber *w_dividing(NSString *oneStr,NSString *twoStr);
//加
+(NSDecimalNumber*)w_addingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr;
//减
+(NSDecimalNumber*)w_subtractingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr;
//乘
+(NSDecimalNumber*)w_multiplyingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr;
//除
+(NSDecimalNumber*)w_dividingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr;
// Original
// value 1.2 1.21 1.25 1.35 1.27
// Plain 1.2 1.2 1.3 1.4 1.3 四舍五入
// Down 1.2 1.2 1.2 1.3 1.2 向下取整
// Up 1.2 1.3 1.3 1.4 1.3 向上取整
// Bankers 1.2 1.2 1.2 1.4 1.3 (特殊的四舍五入，碰到保留位数后一位的数字为5时，根据前一位的奇偶性决定。为偶时向下取整，为奇数时向上取整。如：1.25保留1为小数。5之前是2偶数向下取整1.2；1.35保留1位小数时。5之前为3奇数，向上取整1.4）
+(NSDecimalNumber*)w_numberString:(NSString*)number leftDecimalMode:(NSRoundingMode)mode scale:(int)scale exactness:(BOOL)exactness overflow:(BOOL)overflow underflow:(BOOL)underflow divideByZero:(BOOL)divide;
+(NSDecimalNumber*)w_numberString:(NSString*)number scale:(int)scale;
//
+(NSComparisonResult)w_compareOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr;
@end

NS_ASSUME_NONNULL_END
