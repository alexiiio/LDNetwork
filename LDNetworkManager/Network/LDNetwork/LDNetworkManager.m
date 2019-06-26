//
//  LDNetworkManager.m
//  AFNetworking
//
//  Created by lidi on 2019/5/30.
//

#import "LDNetworkManager.h"
#import "LDNetWorkCache.h"

static NSHashTable *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;
@implementation LDNetworkManager
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 30.f;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        
        _allSessionTask = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:0];
    });
}

+ (NSURLSessionTask *)GET:(NSString *)URL parameters:(id)parameters success:(LDRequestSuccess)success failed:(LDRequestFailed)failed {
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_allSessionTask removeObject:task];
        success ? success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_allSessionTask removeObject:task];
        failed ? failed(error):nil;
    }];
    [_allSessionTask addObject:sessionTask];
    return sessionTask;
}

+ (NSURLSessionTask *)POST:(NSString *)URL parameters:(id)parameters success:(LDRequestSuccess)success failed:(LDRequestFailed)failed {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_allSessionTask removeObject:task];
        success ? success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_allSessionTask removeObject:task];
        failed ? failed(error):nil;
    }];
    [_allSessionTask addObject:sessionTask];
    return sessionTask;
}

+ (void)cancelAllRequest {
    @synchronized(self) {
        for (NSURLSessionTask *task in _allSessionTask) {
            [task cancel];
        }
        [_allSessionTask removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        for (NSURLSessionTask *task in _allSessionTask) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [_allSessionTask removeObject:task];
                break;
            }
        }
    }
}



#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(LDRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==LDRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(LDResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==LDResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}


@end
