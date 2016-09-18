//
//  LogHelper.h
//  SimpleCommon
//
//  Created by wuyp on 16/6/16.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogHelper : NSObject

+ (instancetype)shareInstance;

- (void)redirectSTD:(int)fd;

@end
