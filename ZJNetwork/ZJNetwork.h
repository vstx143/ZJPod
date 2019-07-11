//
//  WNetwork.h
//  WNetwork
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

//请求类型 POST GET DELE
typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2,
    RequestMethodTypeDele = 3
};

//请求参数是否为JSON
typedef NS_ENUM(NSInteger, RequestDataType) {
    RequestDataTypeJson,
    RequestDataTypeNormal,
    RequestJsonResopnseHttp,
    RequestHttpResponseHttp
};

@interface ZJNetwork : NSObject
+(ZJNetwork*)shareZJNetwork;
/**
 服务器请求
 @param methodType 请求方法
 @param dataType   请求类型
 @param url        全路径
 @param params     请求参数
 @param isCookie   是否有Cookie
 @param values     请求头设置
 @param success    成功后回调
 @param failure    失败后回调
 */
- (void)w_requestWithUrl:(NSString *)url
                  method:(RequestMethodType)methodType
         requestDataType:(RequestDataType)dataType
                  params:(nullable id)params
                isCookie:(BOOL)isCookie
            headerValues:(nullable NSDictionary*)values
                 success:(nullable void (^)(id response))success
                 failure:(nullable void (^)(NSError *err))failure;

/**
 上传图片\上传视频文件\上传音频文件
 @param url 全路径
 @param dataType 请求类型
 @param fileDatas  文件数组
 @param severName 服务器解析用的
 @param postfix 文件后缀 如：png / mp4/wav
 @param mimeType 接受的文件类型如：http://tool.oschina.net/commons/
 @param params 请求参数
 @param isCookie 是否cookie
 @param values 请求头
 @param success 成功回调
 @param failure 失败回调
 */
-(void)w_uploadFileWithUrl:(NSString *)url
           requestDataType:(RequestDataType)dataType
                 fileDatas:(nullable NSArray<NSData*>*)fileDatas
               filePostfix:(NSString*)postfix
                 severName:(NSString*)severName
                  mimeType:(NSString*)mimeType
                    params:(nullable id)params
                  isCookie:(BOOL)isCookie
              headerValues:(nullable NSDictionary*)values
                  progress:(nullable void (^)(NSProgress *progress))progress
                   success:(nullable void (^)(id response))success
                   failure:(nullable void (^)(NSError *err))failure;

@end

NS_ASSUME_NONNULL_END
