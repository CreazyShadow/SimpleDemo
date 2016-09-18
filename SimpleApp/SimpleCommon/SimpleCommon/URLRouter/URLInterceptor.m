//
//  URLInterceptor.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLInterceptor.h"
#import "URLRouter.h"
#import "NSError+URLRouter.h"
#import "URLOpenOptions.h"

@implementation URLInterceptor

+ (Class)modelCustomClassForDictionary:(NSDictionary *)dic {
    NSString *className = dic[@"class"];
    if (className.length > 0) {
        Class clz = NSClassFromString(className);
        if (clz) {
            return clz;
        }
    }
    
    return self.class;
}

- (BOOL)isMatchURLWithInput:(URLInput *)input {
    return NO;
}

- (void)interceptWithURL:(NSString *)url originalInput:(URLInput *)originalInput originalCompletion:(void (^)(URLResult *))originalCompletion {
    URLOpenOptions *options = originalInput.options ? : [URLOpenOptions new];
    if (options) {
        options.sourceURL = originalInput.url;
    }
    
    [URLRouter openURL:url options:options completion:^(URLResult *r2) {
        if (originalCompletion) {
            NSError *error = [NSError interceptErrorWithURL:originalInput.url interceptor:self];
            URLResult *result = [URLResult resultWithInput:originalInput source:nil destination:nil error:error];
            result.refer = r2;
            originalCompletion(result);
        }
    }];
}

@end
