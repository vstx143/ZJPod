//
//  ZJSaveData.m
//  MainTest
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZJBaseSaveData.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>

@interface ZJBaseSaveData ()
@property(nonatomic,strong) NSString *AESKey;
@end

@implementation ZJBaseSaveData
-(instancetype)init{
    if (self = [super init]) {
        _AESKey = [self md5String:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] ];
        if (_AESKey.length == 0) {
            _AESKey = [self md5String:NSStringFromClass([self class])];
        }
    }
    return self;
}

#pragma mark -- NSUserDefault
-(void)UDSaveValue:(id)value key:(NSString*)key{
    NSData *encodeData = [self encodeValue:value];
    if (encodeData == nil) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:encodeData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString*)UDGetValueWithKey:(NSString*)key{
    return [[NSString alloc]initWithData:[self decodeValue:[[NSUserDefaults standardUserDefaults] valueForKey:key]] encoding:NSUTF8StringEncoding];
}
#pragma mark ---  keychain
-(void)KCAddOrUpdateAccount:(NSString*)account password:(NSString*)password{
    if (account.length == 0 || password.length == 0) {
        return;
    }
    ZJKeyChainItem *item = [ZJKeyChainItem new];
    item.account = account;
    item.password = password;
    item.service = _AESKey;
    //
    NSMutableDictionary *query = nil;
    NSMutableDictionary *searchQuery = [item keyChainQuery];
    OSStatus status = -1001;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, nil);
    if (status == errSecSuccess) {
        query = [[NSMutableDictionary alloc]init];
        [query setObject:[password dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
        status = SecItemUpdate((__bridge CFDictionaryRef)(searchQuery), (__bridge CFDictionaryRef)(query));
    }else if(status == errSecItemNotFound){//item not found, create it!
        query = searchQuery;
        [query setObject:[password dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }else{
        NSLog(@"--------keychain 存储失败");
    }
}
-(void)KCDeletePasswordWithAccount:(NSString*)account{
    if (account.length == 0) {
        return;
    }
    ZJKeyChainItem *item = [ZJKeyChainItem new];
    item.account = account;
    item.service = _AESKey;
    NSMutableDictionary *searchQuery = [item keyChainQuery];
    OSStatus status = -1001;
    status = SecItemDelete((__bridge CFDictionaryRef)searchQuery);
    if (status != errSecSuccess) {
        NSLog(@"--------keychain 删除失败");
    }
}
-(NSString*)KCGetPasswordWithAccount:(NSString*)account{
    if (account.length == 0) {
        return @"";
    }
    ZJKeyChainItem *item = [ZJKeyChainItem new];
    item.account = account;
    item.service = _AESKey;
    CFTypeRef result = NULL;
    NSMutableDictionary *searchQuery = [item keyChainQuery];
    [searchQuery setObject:@YES forKey:(__bridge id)kSecReturnData];
    [searchQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    OSStatus status = -1001;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, &result);
    
    if (status == errSecSuccess) {
        return [[NSString alloc]initWithData:(__bridge_transfer NSData *)result encoding:NSUTF8StringEncoding];
    }
    return @"";
}
#pragma mark --- 简单类型 归档
-(NSString*)path{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];
}
-(void)ACSaveValue:(id)value{
    [self ACSaveValue:value fileName:@"zj"];
}
-(NSString*)ACGetValue{
    return [self ACGetValueWithFileName:@"zj"];
}
-(void)ACSaveValue:(id)value fileName:(NSString*)name{
    [NSKeyedArchiver archiveRootObject:[self valueToData:value] toFile:[self customPathWithName:name]];
}
-(NSString*)ACGetValueWithFileName:(NSString*)name{
    return [[NSString alloc]initWithData:[NSKeyedUnarchiver unarchiveObjectWithFile:[self customPathWithName:name]] encoding:NSUTF8StringEncoding];
}
-(NSString*)customPathWithName:(NSString*)name{
    NSString *lhomePath = NSHomeDirectory();
    NSString *lfileName = [NSString stringWithFormat:@"Documents/%@.archiver",name];
    NSString *lpath =[lhomePath stringByAppendingPathComponent:lfileName];
    return lpath;
}
#pragma mark 数据简单加密、解密
-(NSData *)objectToJson:(id)obj{
    if (obj == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
    return jsonData;
}
-(NSData*)valueToData:(id)value{
    NSData *data = nil;
    if ([value isKindOfClass:[NSString class]]) {
        data = [value dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([value isKindOfClass:[NSData class]]){
        data  = value;
    }else if ([value isKindOfClass:[NSArray class]] ||
              [value isKindOfClass:[NSDictionary class]]){
        data = [self objectToJson:value];
    }else{
        NSAssert([value isKindOfClass:[NSString class]]||[value isKindOfClass:[NSArray class]]||[value isKindOfClass:[NSDictionary class]]||[value isKindOfClass:[NSData class]], @"ZJBaseSaveData:value只能是基本数据类型，NSString、NSArray、NSDictionary、NSData");
    }
    return data;
}
- (NSString *)md5String:(NSString*)value {
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
-(NSData*)encodeValue:(id)value{
    NSData *data = [self valueToData:value];
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [_AESKey getCString:keyPtr maxLength:sizeof(_AESKey) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if(cryptStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}
-(NSData*)decodeValue:(NSData*)value{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [_AESKey getCString:keyPtr maxLength:sizeof(_AESKey) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [value length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [value bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    if(cryptStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}
@end
#pragma mark ZJKeyChainItem Class
@implementation ZJKeyChainItem
-(NSMutableDictionary*)keyChainQuery{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    if (self.service) {
        [dictionary setObject:self.service forKey:(__bridge id)kSecAttrService];
    }
    if (self.account) {
        [dictionary setObject:self.account forKey:(__bridge id)kSecAttrAccount];
    }
    return dictionary;
}
@end
