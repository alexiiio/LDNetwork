//
//  QDResponseIssueHandler.h
//  Amusing
//
//  Created by lidi on 2019/5/22.
//  Copyright © 2019 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger NetWorkErrorCode = -500;

/*
 处理网络请求 code 不等于0的情况
 */
@interface QDResponseIssueHandler : NSObject
+ (void)handleIssueWithResponseCode:(NSInteger)code responseMessage:(NSString *)message;
@end


