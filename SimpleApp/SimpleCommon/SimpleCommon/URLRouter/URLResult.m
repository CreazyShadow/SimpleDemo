//
//  URLResult.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLResult.h"
#import "URLInput.h"
#import "URLOpenOptions.h"
#import "NSError+URLRouter.h"

@implementation URLResult

+ (instancetype)resultWithInput:(URLInput *)input source:(UIViewController *)source destination:(UIViewController *)destination error:(NSError *)error {
    URLResult *result = [self new];
    result.input = input;
    result.success = error == nil;
    result.sourceViewController = source ? : input.options.sourceViewController;
    result.destinationViewController = destination;
    result.error = error;
    return result;
}

+ (instancetype)errorResultWithInput:(URLInput *)input message:(NSString *)message {
    NSString *desc = [NSString stringWithFormat:@"url: %@, message: %@", input.url, message];
    NSError *error = [NSError errorWithDomain:URLErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: desc}];
    return [self resultWithInput:input source:nil destination:nil error:error];
}

@end
