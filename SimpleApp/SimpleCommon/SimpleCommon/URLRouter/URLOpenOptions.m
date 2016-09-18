//
//  URLOpenOptions.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLOpenOptions.h"

NSString *const URLOpenActionPush = @"push";
NSString *const URLOpenActionPresent = @"present";

@implementation URLOpenOptions

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animated = YES;
    }
    return self;
}

+ (instancetype)optionsWithViewProperties:(NSDictionary *)viewProperties
{
    URLOpenOptions *options = self.new;
    options.viewProperties = viewProperties;
    return options;
}

+ (instancetype)optionsWithParameters:(NSDictionary *)parameters
{
    URLOpenOptions *options = self.new;
    options.parameters = parameters;
    return options;
}

@end
