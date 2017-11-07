//
//  Man.h
//  SimpleModel
//
//  Created by wuyp on 2016/12/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EatProtocol.h"

@interface Man : NSObject <EatProtocol, NSCopying, NSMutableCopying>

@property (nonatomic, copy) NSString *name;

@end
