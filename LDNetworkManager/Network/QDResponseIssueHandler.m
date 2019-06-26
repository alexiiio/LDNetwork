//
//  QDResponseIssueHandler.m
//  Amusing
//
//  Created by lidi on 2019/5/22.
//  Copyright © 2019 Li. All rights reserved.
//

#import "QDResponseIssueHandler.h"


@interface QDResponseIssueHandler ()

@end

@implementation QDResponseIssueHandler
+ (void)handleIssueWithResponseCode:(NSInteger)code responseMessage:(NSString *)message {
    switch (code) {
        case 3:  // 未开通资金账户
        {
         // do something ...
            
        }
            break;
        case 0:
            break;
        case NetWorkErrorCode:

            break;
        default:

            break;
    }
}



@end
