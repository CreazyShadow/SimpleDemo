//
//  NSError+URLRouter.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLInterceptor.h"

extern NSString *const URLErrorDomain;
extern NSString *const URLErrorURLKey;
extern NSString *const URLErrorExceptionKey;
extern NSString *const URLErrorInterceptorKey;

@interface NSError (URLRouter)

+ (instancetype)errorWithURLException:(NSException *)exception;
+ (instancetype)interceptErrorWithURL:(NSString *)url interceptor:(URLInterceptor *)interceptor;

@end
