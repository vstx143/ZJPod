//
//  WNetwork.m
//  WNetwork
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "WZJNetwork.h"
#import <AFNetworking/AFNetworking.h>

static  NSString *const KCookieKey = @"WNetworkCookieKey";

@interface WZJNetwork()
@property(nonatomic,strong)AFHTTPSessionManager *wSessionManager;
@end
@implementation WZJNetwork
+(WZJNetwork*)shareWZJNetwork{
    static WZJNetwork *instanceNet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceNet = [[self alloc]init];
    });
    return instanceNet;
}
-(instancetype)init{
    if (self = [super init]) {
        self.wSessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}
//装配情求头
-(void)configHeaderValue:(NSDictionary*)headerDict{
    if (headerDict != nil) {
        [headerDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.wSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
}
//存储cookie
-(void)configCookie{
    NSData * cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey:KCookieKey];
    [defaults synchronize];
}
//设置请求类型
-(void)configRequestDataType:(RequestDataType)dataType toManager:(AFHTTPSessionManager*)manager{
    switch (dataType) {
        case RequestDataTypeJson:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
            break;
        case RequestDataTypeNormal:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case RequestHttpResponseHttp:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case RequestJsonResopnseHttp:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
}
/**
 *  发送请求
 */
- (void)w_requestWithManager:(AFHTTPSessionManager *)manager method:(RequestMethodType)methodType url:(NSString *)baseURL params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    switch (methodType) {
        case RequestMethodTypeGet:{
            //GET请求
            [manager GET:baseURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    [self configCookie];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:{
            //POST请求
            [manager POST:baseURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                   [self configCookie];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypeDele:{
            //DELE请求
            [manager DELETE:baseURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                   [self configCookie];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
        default:
            break;
    }
}

/**
 *  服务器请求
 */
- (void)w_requestWithUrl:(NSString *)url
                  method:(RequestMethodType)methodType
         requestDataType:(RequestDataType)dataType
                  params:(id)params
                isCookie:(BOOL)isCookie
            headerValues:(NSDictionary*)values
                 success:(void (^)(id response))success failure:(void (^)(NSError *err))failure{
    AFHTTPSessionManager* manager = self.wSessionManager;
    //设置cookie
    if (isCookie) {
        manager.requestSerializer.HTTPShouldHandleCookies = YES;
        NSData *cookiesData = [[NSUserDefaults standardUserDefaults] objectForKey:KCookieKey];
        if (cookiesData) {
            NSArray * cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
            NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie * cookie in cookies){
                [cookieStorage setCookie: cookie];
            }
        }
    }
    //设置请求类型
    [self configRequestDataType:dataType toManager:manager];
    //设置header
    [self configHeaderValue:values];
    
    [self w_requestWithManager:manager method:methodType url:url params:params success:^(id response) {
        if (success) {
            if (methodType == RequestDataTypeNormal) {
                if ([response isKindOfClass:[NSData class]]) {
                    success([[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding]);
                }else{
                    success(response);
                }
            }else{
                if ([response isKindOfClass:[NSData class]]) {
                    success([[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding]);
                }else{
                    success(response);
                }
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  上传文件
 */
-(void)w_uploadFileWithUrl:(NSString *)url
           requestDataType:(RequestDataType)dataType
                 fileDatas:(NSArray<NSData*>*)fileDatas
               filePostfix:(NSString*)postfix
                 severName:(NSString*)severName
                  mimeType:(NSString*)mimeType
                    params:(id)params
                  isCookie:(BOOL)isCookie
              headerValues:(NSDictionary*)values
                  progress:(nullable void (^)(NSProgress *progress))progress
                   success:(void (^)(id response))success
                   failure:(void (^)(NSError *err))failure
{
    AFHTTPSessionManager* manager = self.wSessionManager;
    //设置cookie
    if (isCookie) {
        manager.requestSerializer.HTTPShouldHandleCookies = YES;
        NSData *cookiesData = [[NSUserDefaults standardUserDefaults] objectForKey:KCookieKey];
        if (cookiesData) {
            NSArray * cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
            NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie * cookie in cookies){
                [cookieStorage setCookie: cookie];
            }
        }
    }
    //设置header
    [self configHeaderValue:values];
    //设置请求类型
    [self configRequestDataType:dataType toManager:manager];
    // 访问路径
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
        for (NSData *fileData in fileDatas) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.%@", str,postfix];
            
            [formData appendPartWithFileData:fileData name:severName fileName:fileName mimeType:mimeType];
        }
       
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [self configCookie];
            //
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
