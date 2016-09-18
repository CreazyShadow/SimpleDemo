//
//  NSError+URLRouter.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "NSError+URLRouter.h"

NSString *const URLErrorDomain = @"YZTURLErrorDomain";
NSString *const URLErrorURLKey = @"url";
NSString *const URLErrorExceptionKey = @"exception";
NSString *const URLErrorInterceptorKey = @"interceptor";

@implementation NSError (URLRouter)

+ (instancetype)errorWithURLException:(NSException *)exception {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (exception) {
        userInfo[URLErrorExceptionKey] = exception;
        if (exception.name) {
            userInfo[NSLocalizedDescriptionKey] = exception.name;
        }
        
        if (exception.reason) {
            userInfo[NSLocalizedFailureReasonErrorKey] = exception.reason;
        }
    }
    
    return [self errorWithDomain:NSURLErrorDomain code:-1 userInfo:userInfo];
}

+ (instancetype)interceptErrorWithURL:(NSString *)url interceptor:(URLInterceptor *)interceptor {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (url) {
        userInfo[NSURLErrorKey] = url;
    }
    
    if (interceptor) {
        userInfo[URLErrorInterceptorKey] = interceptor;
    }
    
//    userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"Interceptor test failed:<%@: %p; name= %@; url = %@>", NSStringFromClass(interceptor.class), interceptor, interceptor.name];
    return [self errorWithDomain:NSURLErrorDomain code:-1 userInfo:userInfo];
}

@end
