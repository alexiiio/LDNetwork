//
//  QDResponseObject.m
//  LDNetwork_Example
//
//  Created by lidi on 2019/5/30.
//  Copyright © 2019 alexiiio. All rights reserved.
//

#import "QDResponseObject.h"
#import <YYModel/YYModel.h>

@implementation QDResponseObject
- (instancetype)initWithCoder:(NSCoder *)coder
{
    return [self yy_modelInitWithCoder:coder];
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [self yy_modelEncodeWithCoder:coder];
}
@end
