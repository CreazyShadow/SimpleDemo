//
//  URLConfigurableInterceptor.h
//  SimpleCommon
//
//  Created by wuyp on 16/5/24.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLInterceptor.h"

@interface URLConfigurableInterceptor : URLInterceptor

@property (strong, nonatomic) NSArray<NSString *> *urls;
@property (strong, nonatomic) NSArray<NSString *> *urlPrefixs;
@property (strong, nonatomic) NSArray<NSString *> *except;
@property (strong, nonatomic) NSArray<NSString *> *exceptPrefixs;

/// url的参数是否参与匹配
@property (nonatomic) BOOL shouldMatchParameters;

@end
