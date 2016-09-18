//
//  URLResult.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const URLErrorDomain;
extern NSString * const URLExceptionKey;

@class URLInput;
@class URLResult;

@interface URLResult : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, weak) UIViewController *sourceViewController;

@property (nonatomic, weak) UIViewController *destinationViewController;

@property (nonatomic, strong) id response;

@property (nonatomic, strong) NSError *error;

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) URLInput *input;

/**
 *  引用的结果，目前可能是被interceptor打断后interceptor跳转的结果
 */
@property (nonatomic, strong) URLResult *refer;

+ (instancetype)resultWithInput:(URLInput *)input
                         source:(UIViewController *)source
                    destination:(UIViewController *)destination
                          error:(NSError *)error;

+ (instancetype)errorResultWithInput:(URLInput *)input message:(NSString *)message;

@end
