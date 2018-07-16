//
//  OcModule.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/30.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "OcModule.h"

@implementation OcModule

- (void)testName:(NSString *)name dict:(NSDictionary *)dict {
    NSLog(@"1111111");
}

- (void)testName:(NSString *)name dict:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo {
    NSLog(@"222222");
}

+ (OcModule *)requestWithBaseURLStr:(NSString *)URLString params:(NSDictionary *)params httpMethod:(HTTPReqMethodTypeE)httpMethod success:(void (^)(OcModule * _Nonnull, id _Nullable))success failure:(void (^)(OcModule * _Nonnull, NSError * _Nullable))failure {
    NSLog(@"...no userinfo");
    return [OcModule new];
}

+ (OcModule *)requestWithBaseURLStr:(NSString *)URLString params:(NSDictionary *)params httpMethod:(HTTPReqMethodTypeE)httpMethod userInfo:(NSDictionary *)userInfo success:(void (^)(OcModule * _Nonnull, id _Nullable))success failure:(void (^)(OcModule * _Nonnull, NSError * _Nullable))failure {
    NSLog(@"... userinfo");
    return [OcModule new];
}

@end
