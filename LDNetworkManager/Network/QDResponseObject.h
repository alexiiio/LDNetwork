//
//  QDResponseObject.h
//  LDNetwork_Example
//
//  Created by lidi on 2019/5/30.
//  Copyright © 2019 alexiiio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDResponseObject : NSObject<NSCoding>

@property (nonatomic, assign)NSInteger code;
@property (nonatomic, strong)NSString * message;
@property (nonatomic, strong)id result;
@property (nonatomic, assign)BOOL success;

@end
