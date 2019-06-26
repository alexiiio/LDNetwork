//
//  LDNetworkManager.h
//  AFNetworking
//
//  Created by lidi on 2019/5/30.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, LDRequestSerializer) {
    LDRequestSerializerJSON,
    LDRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, LDResponseSerializer) {
    LDResponseSerializerJSON,
    LDResponseSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, LDRequestMethod) {
    LDRequestMethodGET,
    LDRequestMethodPOST,
    LDRequestMethodPUT,
    LDRequestMethodDELETE,
    LDRequestMethodHEAD
};

typedef void(^LDRequestSuccess)(id _Nullable responseObject);
typedef void(^LDRequestFailed)(NSError *_Nullable error);
typedef void(^LDResponseCache)(id _Nullable responseCache);


@interface LDNetworkManager : NSObject

+ (NSURLSessionTask *_Nullable)GET:(NSString *_Nullable)URL parameters:(id _Nullable )parameters success:(LDRequestSuccess _Nullable )success failed:(LDRequestFailed _Nullable )failed;
+ (NSURLSessionTask *_Nullable)POST:(NSString *_Nullable)URL parameters:(id _Nullable )parameters success:(LDRequestSuccess _Nullable )success failed:(LDRequestFailed _Nullable )failed;


+ (void)setAFHTTPSessionManagerProperty:(void(^_Nullable)(AFHTTPSessionManager * _Nullable sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 */
+ (void)setRequestSerializer:(LDRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 */
+ (void)setResponseSerializer:(LDResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 设置请求头
 */
+ (void)setValue:(NSString *_Nullable)value forHTTPHeaderField:(NSString *_Nullable)field;

@end


