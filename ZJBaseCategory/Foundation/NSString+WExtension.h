//
//  NSString+WExtension.h
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(WExtension)
- (NSURL *)w_convertToURL;
- (NSURL *)w_convertToURLRelativeToURL:(NSURL*)baseURL;

- (NSString *)w_md5;
- (NSString *)w_URLEncode;
- (NSString *)w_encodeBase64;
- (NSString *)w_decodeBase64;

- (BOOL)w_isEmail;
- (BOOL)w_isPhoneNumber;
- (BOOL)w_hasString:(NSString *)substring;
- (BOOL)w_isNotEmpty;
- (BOOL)w_isNumber;
/**判断银行卡号*/
+ (BOOL)w_checkBankCardNo:(NSString *)cardNo;

/**验证是否中文名*/
- (BOOL)w_isRealName;
/**
 *验证身份证号
 */
- (BOOL)w_validateIDCardNumber:(NSString *)value;
/**
 * 判断字段是否包含空格
 */
- (BOOL)w_validateContainsSpace;

/**
 *  根据身份证返回岁数
 */
- (NSString *)w_ageFromIDCard;

/**
 *  根据身份证返回生日
 */
- (NSString*)w_birthdayFromIDCard;

/**
 *  根据身份证返回性别
 */
- (NSString*)w_sexFromIDCard;
/**手机加星号*/
- (NSString *)w_phoneHiddenPartlyWords;
//判断是否为整形：
-(BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;
//检测密码
- (BOOL)w_isSafePassword:(NSString *)strPwd;
@end

NS_ASSUME_NONNULL_END
