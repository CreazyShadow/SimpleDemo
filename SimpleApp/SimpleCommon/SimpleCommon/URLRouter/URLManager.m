//
//  URLManager.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLManager.h"
#import "URLConfigurableInterceptor.h"
#import "URLInput.h"
#import "NSError+URLRouter.h"
#import "URLHandler.h"
#import "URLLog.h"
#import "URLInterceptor.h"
//#import <YYModel/YYModel.h>

@interface URLManager()

@property (nonatomic, strong) NSMutableDictionary *handlersMetaCache;
@property (nonatomic, strong) NSMutableArray *interceptors;

@property (nonatomic, strong) NSMutableDictionary<NSString *, URLInterceptor *> *urlInterceptorsCache;
@property (nonatomic, strong) NSMutableArray<URLInterceptor *> *parameterMatchingInterceptors;

@end

@implementation URLManager

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
        instance = [self new];
        URLLog(@"duration = %f", [NSDate timeIntervalSinceReferenceDate] - start);
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadConfiguration];
    }
    
    return self;
}

#pragma mark - public

- (BOOL)canOpenURL:(NSString *)url {
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    components.query = nil;
    components.fragment = nil;
    components.user = nil;
    components.password = nil;
    NSString *pattern = components.URL.absoluteString;
    
    BOOL found = pattern && self.handlersMetaCache[pattern];
    if (!found) {
        NSString *schema = components.scheme.lowercaseString;
        found = schema && self.handlersMetaCache[schema];
    }
    
    return found;
}

- (void)openURL:(NSString *)url options:(URLOpenOptions *)options completion:(void (^)(URLResult *))completion {
    void(^c2)(URLResult *result) = ^(URLResult *result) {
        URLResult *output = [self processPostInterceptorsWithInput:result.input result:result];
        if (completion) {
            completion(result);
        }
    };
    
    URLInput *input = [self parseURLWithString:url options:options];
    NSError *error;
    if (![self processPreInterceptorsWithInput:input completion:completion]) {
        return;
    }
    
    NSDictionary *meta = self.handlersMetaCache[input.pattern];
    if (!meta) {
        meta = self.handlersMetaCache[input.scheme];
    }
    
//    URLHandler *handler = [meta isKindOfClass:[NSDictionary class]] ? [URLInput yy_modelWithDictionary:meta] : nil;
//    if (!handler) {
//        c2([URLResult errorResultWithInput:input message:@"Create handler failed"]);
//        return;
//    }
    
//    [handler openURLWithInput:input completion:completion];
}

- (URLInterceptor *)interceptorForName:(NSString *)name
{
    for (URLInterceptor *interceptor in self.interceptors) {
        if ([interceptor.name isEqualToString:name]) {
            return interceptor;
        }
    }
    return nil;
}

#pragma mark - private

- (void)loadConfiguration {
    NSURL *configURL = [[NSBundle mainBundle] URLForResource:@"URLConfiguration" withExtension:@"plist"];
    NSAssert(configURL, @"Can't find configuration file.");
    [self loadConfigurationWithURL:configURL];
}

- (void)loadConfigurationWithURL:(NSURL *)configurationURL {
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfURL:configurationURL];
    NSMutableDictionary *inputs = [NSMutableDictionary dictionary];
    
    NSDictionary *handlerConfigs = config[@"handlers"];
    NSMutableDictionary *handlers = [NSMutableDictionary dictionary];
    void (^block)(NSString *url, NSDictionary *meta) = ^(NSString *url, NSDictionary *meta) {
        handlers[url] = meta;
        URLInput *input = [[URLInput alloc] init];
        input.url = url;
        NSURLComponents *components = [NSURLComponents componentsWithString:url];
        components.query = nil;
        components.fragment = nil;
        components.user = nil;
        components.password = nil;
        input.scheme = components.scheme.lowercaseString;
        input.pattern = components.URL.absoluteString.lowercaseString;
    };
    
    [handlerConfigs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableDictionary *temp = [obj mutableCopy];
        temp[@"name"] = key;
        NSString *url = temp[@"url"];
        NSArray *urls = temp[@"urls"];
        if (urls) {
            [urls enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                temp[@"url"] = obj2;
                block(obj2, temp);
            }];
        }
        
        if (url) {
            block(url, temp);
        }
    }];
    
    self.handlersMetaCache = handlers;
    
    NSDictionary *interceptorConfigs = config[@"interceptors"];
    NSMutableArray<URLConfigurableInterceptor *> *interceptors = [NSMutableArray array];
    [interceptorConfigs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        URLConfigurableInterceptor *interceptor = [URLConfigurableInterceptor yy_modelWithJSON:obj];
        URLConfigurableInterceptor *interceptor = nil;
        if (!interceptor) {
            return;
        }
        
        if (!interceptor.name) {
            interceptor.name = key;
        }
        
        [interceptors sortUsingComparator:^NSComparisonResult(URLConfigurableInterceptor * obj1,
                                                              URLConfigurableInterceptor * obj2) {
            return [obj1.sort compare:obj2.sort];
        }];
        
        self.interceptors = interceptors;
        
        NSMutableDictionary *urlInterceptorsCache = [NSMutableDictionary dictionary];
        NSMutableArray *paramterMatchingInterceptors = [NSMutableArray array];
        [interceptors enumerateObjectsUsingBlock:^(URLConfigurableInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (interceptor.shouldMatchParameters) {
                [paramterMatchingInterceptors addObject:interceptor];
                return;
            }
            
            [inputs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, URLInput *obj, BOOL * _Nonnull stop) {
                if ([interceptor isMatchURLWithInput:obj]) {
                    NSString *key = obj.url;
                    NSMutableArray *temp = urlInterceptorsCache[key];
                    if (!temp) {
                        temp = [NSMutableArray array];
                        urlInterceptorsCache[key] = temp;
                    }
                    
                    [temp addObject:interceptor];
                }
            }];
        }];
        
        self.urlInterceptorsCache = urlInterceptorsCache;
        self.parameterMatchingInterceptors = paramterMatchingInterceptors;
    }];
}

- (URLInput *)parseURLWithString:(NSString *)urlString options:(URLOpenOptions *)options {
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    NSString *schema = components.scheme;
    NSString *query = components.query;
    
    components.query = nil;
    components.fragment = nil;
    components.user = nil;
    components.password = nil;
    NSString *pattern = components.URL.absoluteString;
    
    NSArray *queryItems = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [queryItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *keyValue = [obj componentsSeparatedByString:@"="];
        if (keyValue.count != 2) {
            return;
        }
        
        NSString *key = [keyValue[0] stringByRemovingPercentEncoding];
        if (key.length == 0) {
            return;
        }
        
        NSString *value = [keyValue[1] stringByRemovingPercentEncoding];
        if (value.length == 0) {
            return;
        }
        
        id oldValue = paramters[key];
        if (oldValue) {
            if (![oldValue isKindOfClass:[NSMutableArray class]]) {
                oldValue = [NSMutableArray arrayWithObject:oldValue];
                paramters[key] = oldValue;
            }
            
            [oldValue addObject:value];
        } else {
            paramters[key] = value;
        }
    }];
    
    if (options.parameters.count > 0) {
        [paramters addEntriesFromDictionary:options.parameters];
    }
    
    URLInput *inputs = [[URLInput alloc] init];
    inputs.url = urlString;
    inputs.scheme = schema.lowercaseString;
    inputs.pattern = pattern.lowercaseString;
    inputs.parameters = paramters;
    inputs.options = options;
    return inputs;
}

- (BOOL)processPreInterceptorsWithInput:(URLInput *)input completion:(void (^)(URLResult *result))completion
{
    if (!input.pattern) {
        return YES;
    }
    
    __block BOOL pass = YES;
    void (^block)(URLInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) = ^(URLInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj respondsToSelector:@selector(shouldOpenURLWithInput:completion:)]) {
            return;
        }
        if (![obj shouldOpenURLWithInput:input completion:completion]) {
            pass = NO;
            *stop = YES;
        }
    };
    
    NSArray<URLInterceptor *> *interceptors = self.urlInterceptorsCache[input.pattern];
    [interceptors enumerateObjectsUsingBlock:block];
    if (!pass) {
        return NO;
    }
    
    [self.parameterMatchingInterceptors enumerateObjectsUsingBlock:block];
    return pass;
}

- (URLResult *)processPostInterceptorsWithInput:(URLInput *)input result:(URLResult *)result
{
    if (!input.pattern) {
        return result;
    }
    
    __block URLResult *output = result;
    void (^block)(URLInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) = ^(URLInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(didOpenURLWithInput:result:)]) {
            output = [obj didOpenURLWithInput:input result:result];
        }
    };
    NSArray<URLInterceptor *> *interceptors = self.urlInterceptorsCache[input.pattern];
    [interceptors enumerateObjectsUsingBlock:block];
    [self.parameterMatchingInterceptors enumerateObjectsUsingBlock:block];
    return output;
}

@end
