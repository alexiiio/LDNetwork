//
//  LDNetWorkCache.h
//  AFNetworking
//
//  Created by lidi on 2019/5/30.
//

#import <Foundation/Foundation.h>


@interface LDNetWorkCache : NSObject
/**
 *  异步缓存网络数据,根据请求的 URL与parameters
 *  做KEY存储数据, 这样就能缓存多级页面的数据
 *
 *  @param httpData   服务器返回的数据
 *  @param URL        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(id)parameters;

/**
 *  根据请求的 URL与parameters 同步取出缓存数据
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *
 *  @return 缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(id)parameters;
+ (void)removeCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;


/// 获取磁盘缓存的总大小 bytes(字节)
+ (NSInteger)getAllDiskCacheSize;

/// 删除所有磁盘缓存
+ (void)removeAllDiskCache;

+ (void)setCustomCache:(id)cacheData forKey:(NSString *)cacheKey;
+ (void)setCustomCache:(id)cacheData forKey:(NSString *)cacheKey withBlock:(void(^)(void))block;
+ (id)getCustomCacheByKey:(NSString *)cacheKey;
+ (void)removeCustomCache:(id)cacheData forKey:(NSString *)cacheKey;

@end


