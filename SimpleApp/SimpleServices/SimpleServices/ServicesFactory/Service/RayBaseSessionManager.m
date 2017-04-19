//
//  RaySessionManager.m
//  SimpleServices
//
//  Created by wuyp on 2017/3/30.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RayBaseSessionManager.h"

@interface RayBaseSessionManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSDictionary *prams;

@end

@implementation RayBaseSessionManager

#pragma mark - init

- (RayBaseSessionManager *)manager {
    RayBaseSessionManager *instance = [[RayBaseSessionManager alloc] init];
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.baseURL = [NSURL URLWithString:@""];
        
        //公共参数
        [self setupCommonHeadParams];
        
    }
    
    return self;
}

#pragma mark - cache

- (NSString *)cacheFilePath {
    return @"";
}

- (NSString *)cacheFileDirectory {
    return @"";
}

- (NSString *)cacheFileName {
    return @"";
}

#pragma mark - request

- (void)request:(NSString *)url paramters:(NSDictionary *)parameters success:(void (^)(NSString *, NSString *, id))success failure:(void (^)(NSError *))failure {
    self.sessionManager 
}

#pragma mark - private

- (void)setupCommonHeadParams {
    _headParams = [NSMutableDictionary dictionary];
    
    [_headParams setObject:@"jack" forKey:@"name"];
    [_headParams setObject:@"123" forKey:@"id"];
}

#pragma mark - public


@end
