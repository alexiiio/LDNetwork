//
//  LDNetWorkClient.m
//  LDNetwork_Example
//
//  Created by lidi on 2019/5/30.
//  Copyright © 2019 alexiiio. All rights reserved.
//

#import "QDNetWorkClient.h"
#import "NetworkRequestInterface.h"
#import <YYModel.h>
#import "QDResponseIssueHandler.h"
//#import "QDUserDefaults.h"
#import "LDNetWorkCache.h"

@implementation QDNetWorkClient
+ (void)initialize {
    [LDNetworkManager setRequestSerializer:LDRequestSerializerJSON];
    [LDNetworkManager setResponseSerializer:LDResponseSerializerJSON];
    [LDNetworkManager setRequestTimeoutInterval:30];
}

+ (NSURLSessionTask *)requestWithURL:(NSString *)URL method:(LDRequestMethod)method parameters:(NSDictionary *)parameters success:(QDRequestSuccess)success failed:(LDRequestFailed)failed shouldCache:(BOOL)shouldCache useIssueHandle:(BOOL)useIssueHandle {
//    //把token取出来
//    NSString *token = [NSString stringWithFormat:@"%@", [QDUserDefaults getQDToken]];
//    if (token && ![token isEqualToString:@"(null)"] && ![token isEqualToString:@""]) {
//        [LDNetworkManager setValue:token forHTTPHeaderField:UserLogonToken];
//    }
//    NSLog(@"urlStr:%@ token:%@",URL,token);

    switch (method) {
        case LDRequestMethodGET:
            return [LDNetworkManager GET:URL parameters:parameters success:^(id  _Nullable responseObject) {
                if (responseObject) {
                    QDResponseObject *responseObj = [QDResponseObject yy_modelWithJSON:responseObject];
                    success ? success(responseObj):nil;
                    if (responseObj.code == 0) {
                        if (shouldCache) {
                            [LDNetWorkCache setCustomCache:responseObj forKey:URL];
                        }
                    }else{
                        if (useIssueHandle) {
                            [QDResponseIssueHandler handleIssueWithResponseCode:responseObj.code responseMessage:responseObj.message];
                        }
                    }
                }
            } failed:^(NSError * _Nullable error) {
                failed ? failed(error):nil;
                if (useIssueHandle) {
                    [QDResponseIssueHandler handleIssueWithResponseCode:NetWorkErrorCode responseMessage:nil];
                }
            }];
            break;
        case LDRequestMethodPOST:
            return [LDNetworkManager POST:URL parameters:parameters success:^(id  _Nullable responseObject) {
                if (responseObject) {
                    QDResponseObject *responseObj = [QDResponseObject yy_modelWithJSON:responseObject];
                    success ? success(responseObj):nil;
                    if (responseObj.code == 0) {
                        if (shouldCache) {
                            [LDNetWorkCache setCustomCache:responseObj forKey:URL];
                        }
                    }else{
                        if (useIssueHandle) {
                            [QDResponseIssueHandler handleIssueWithResponseCode:responseObj.code responseMessage:responseObj.message];
                        }
                    }
                }
            } failed:^(NSError * _Nullable error) {
                failed ? failed(error):nil;
                if (useIssueHandle) {
                    [QDResponseIssueHandler handleIssueWithResponseCode:NetWorkErrorCode responseMessage:nil];
                }
            }];
            break;
        default:
            return [LDNetworkManager POST:URL parameters:parameters success:success failed:failed];
            break;
    }
}

+ (NSString *)requestURLWithSubUrl:(NSString *)subUrl {
    return [NSString stringWithFormat:@"%@%@",QDBaseURL,subUrl];
}

+ (NSURLSessionTask *)getRankListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize success:(QDRequestSuccess)success failed:(LDRequestFailed)failed {
    NSDictionary *param = @{@"pageNum":[NSNumber numberWithInteger:pageNum],@"pageSize":[NSNumber numberWithInteger:pageSize]};
    BOOL shouldCache = pageNum == 1 ? YES:NO;
    return [self requestWithURL:[QDNetWorkClient requestURLWithSubUrl:api_getVideoList] method:LDRequestMethodPOST parameters:param success:success failed:failed shouldCache:shouldCache useIssueHandle:YES];
}

@end
