//
//  RaySessionManager.h
//  SimpleServices
//
//  Created by wuyp on 2017/3/30.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, requestMethod) {
    requestMethodGet,
    requestMethodPost
};

@interface RayBaseSessionManager : NSObject

#pragma mark - common params

@property (nonatomic, strong, readonly) NSMutableDictionary *headParams;
@property (nonatomic, assign) BOOL isMemoryCache;
@property (nonatomic, assign) BOOL isDisakCache;
@property (nonatomic, assign) requestMethod method;

#pragma mark - init

- (RayBaseSessionManager *)manager;

#pragma mark - request

- (void)request:(NSString *)url paramters:(NSDictionary *)parameters
        success:(void(^)(NSString *code, NSString *msg, id responseObject))success
        failure:(void(^)(NSError *errror))failure;

#pragma mark - cache

- (NSString *)cacheFilePath;
- (NSString *)cacheFileDirectory;
- (NSString *)cacheFileName;

@end
