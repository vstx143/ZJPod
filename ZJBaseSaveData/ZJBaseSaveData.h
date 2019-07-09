//
//  ZJSaveData.h
//  MainTest
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseSaveData : NSObject

/**
 NSUserDefaults 简单数据存储

 @param value 值
 @param key 键
 */
-(void)UDSaveValue:(id)value key:(NSString*)key;
-(NSString*)UDGetValueWithKey:(NSString*)key;

/**
 keyChain 账户密码存储

 @param account 账户
 @param password 密码
 */
-(void)KCAddOrUpdateAccount:(NSString*)account password:(NSString*)password;
-(void)KCDeletePasswordWithAccount:(NSString*)account;
-(NSString*)KCGetPasswordWithAccount:(NSString*)account;

/**
 Archive 存储

 @param value 基本数据类型
 */
-(void)ACSaveValue:(id)value;
-(NSString*)ACGetValue;
//
/**
 Archive 指定文件名存储

 @param value 基本数据类型
 @param name 文件名 （xxx）
 */
-(void)ACSaveValue:(id)value fileName:(NSString*)name;
-(NSString*)ACGetValueWithFileName:(NSString*)name;
@end

@interface ZJKeyChainItem : NSObject
@property(nonatomic,copy) NSString *service;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;

-(NSMutableDictionary*)keyChainQuery;
@end
NS_ASSUME_NONNULL_END
