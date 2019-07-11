//
//  NSDecimalNumber+Extention.m
//  CartTest
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NSDecimalNumber+Extention.h"

@implementation NSDecimalNumber(Extention)
+(NSDecimalNumber*)w_addingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr{
    NSDecimalNumber *loneStr = [NSDecimalNumber decimalNumberWithString:oneStr];
    NSDecimalNumber *ltwoStr = [NSDecimalNumber decimalNumberWithString:twoStr];
    return [loneStr decimalNumberByAdding:ltwoStr];
}
//减
+(NSDecimalNumber*)w_subtractingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr{
    NSDecimalNumber *loneStr = [NSDecimalNumber decimalNumberWithString:oneStr];
    NSDecimalNumber *ltwoStr = [NSDecimalNumber decimalNumberWithString:twoStr];
    return [loneStr decimalNumberBySubtracting:ltwoStr];
}
//乘
+(NSDecimalNumber*)w_multiplyingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr{
    NSDecimalNumber *loneStr = [NSDecimalNumber decimalNumberWithString:oneStr];
    NSDecimalNumber *ltwoStr = [NSDecimalNumber decimalNumberWithString:twoStr];
    return [loneStr decimalNumberByMultiplyingBy:ltwoStr];
}
//除
+(NSDecimalNumber*)w_dividingOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr{
    NSDecimalNumber *loneStr = [NSDecimalNumber decimalNumberWithString:oneStr];
    NSDecimalNumber *ltwoStr = [NSDecimalNumber decimalNumberWithString:twoStr];
    return [loneStr decimalNumberByDividingBy:ltwoStr];
}
//scale：保留有效小数的个数（为0的无效小数后自动过滤).
//Exactness：进度异常、
//Overflow:向上溢出、
//Underflow：向下溢出、
//DivideByZero：除数为0。当参数为YES出错会抛出异常，为NO时忽略异常。返回nil.
+(NSDecimalNumber*)w_numberString:(NSString*)number leftDecimalMode:(NSRoundingMode)mode scale:(int)scale exactness:(BOOL)exactness overflow:(BOOL)overflow underflow:(BOOL)underflow divideByZero:(BOOL)divide{
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:mode
                                       scale:scale
                                       raiseOnExactness:exactness
                                       raiseOnOverflow:overflow
                                       raiseOnUnderflow:underflow
                                       raiseOnDivideByZero:divide];
    NSDecimalNumber *lnumber = [NSDecimalNumber decimalNumberWithString:number];
    return [lnumber decimalNumberByRoundingAccordingToBehavior:roundUp];
}
+(NSDecimalNumber*)w_numberString:(NSString*)number scale:(int)scale{
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                       scale:scale
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:NO];
    NSDecimalNumber *lnumber = [NSDecimalNumber decimalNumberWithString:number];
    return [lnumber decimalNumberByRoundingAccordingToBehavior:roundUp];
}
+(NSComparisonResult)w_compareOneNumberString:(NSString*)oneStr twoNumberString:(NSString*)twoStr{
    NSDecimalNumber *loneStr = [NSDecimalNumber decimalNumberWithString:oneStr];
     NSDecimalNumber *ltwoStr = [NSDecimalNumber decimalNumberWithString:twoStr];
    return  [loneStr compare:ltwoStr];
    
}
@end

