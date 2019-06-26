//
//  LDNetWorkClient.h
//  LDNetwork_Example
//
//  Created by lidi on 2019/5/30.
//  Copyright © 2019 alexiiio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDNetworkManager.h"
#import "QDResponseObject.h"

typedef void(^QDRequestSuccess)(QDResponseObject *responseObject);


@interface QDNetWorkClient : NSObject
+ (NSString *)requestURLWithSubUrl:(NSString *)subUrl;
// 首页 这好玩 榜单列表
+ (NSURLSessionTask *)getRankListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize success:(QDRequestSuccess)success failed:(LDRequestFailed)failed;

@end


