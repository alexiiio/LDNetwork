//
//  LDNetWorkCache.m
//  AFNetworking
//
//  Created by lidi on 2019/5/30.
//

#import "LDNetWorkCache.h"
#import "YYCache.h"

static NSString *const kLDNetWorkCache = @"kLDNetWorkCache";

@implementation LDNetWorkCache
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kLDNetWorkCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache setObject:httpData forKey:cacheKey];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}
+ (void)removeCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache removeObjectForKey:cacheKey];
}


+ (NSInteger)getAllDiskCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllDiskCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (void)setCustomCache:(id)cacheData forKey:(NSString *)cacheKey
{
    [_dataCache setObject:cacheData forKey:cacheKey];
}

+ (id)getCustomCacheByKey:(NSString *)cacheKey
{
    return [_dataCache objectForKey:cacheKey];
}
+ (void)setCustomCache:(id)cacheData forKey:(NSString *)cacheKey withBlock:(void(^)(void))block{
    [_dataCache setObject:cacheData forKey:cacheKey withBlock:block];
}
+ (void)removeCustomCache:(id)cacheData forKey:(NSString *)cacheKey
{
    [_dataCache removeObjectForKey:cacheKey];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}

@end
