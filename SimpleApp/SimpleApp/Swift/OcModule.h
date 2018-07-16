//
//  OcModule.h
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/30.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTTPReqMethodTypeE) {
    kHTTPReqMethodTypeGET         = 0,
    kHTTPReqMethodTypePOST        = 1,
    kHTTPReqMethodTypeDELETE      = 2,
};


@interface OcModule : NSObject

- (CGFloat)widthWithView:( UIView * _Nullable )view;
- (UIImage * _Nullable)imgFromColor:(UIColor * _Nullable)color;

+ (void)testName:(NSString *_Nullable)name dict:(NSDictionary * _Nullable)dict;
+ (void)testName:(NSString *_Nullable)name dict:(NSDictionary * _Nullable)dict userInfo:(NSDictionary * _Nullable)userInfo;

+ (OcModule *_Nonnull)requestWithBaseURLStr:(NSString *_Nullable)URLString
                                     params:(NSDictionary *_Nullable)params
                                 httpMethod:(HTTPReqMethodTypeE)httpMethod
                                    success:(void (^_Nonnull)(OcModule * _Nonnull request, id _Nullable responseObject))success
                                    failure:(void (^_Nonnull)(OcModule * _Nonnull request, NSError * _Nullable error))failure;

+ (OcModule *_Nonnull)requestWithBaseURLStr:(NSString *_Nullable)URLString
                                     params:(NSDictionary *_Nullable)params
                                 httpMethod:(HTTPReqMethodTypeE)httpMethod
                                   userInfo:(NSDictionary* _Nullable)userInfo
                                    success:(void (^_Nonnull)(OcModule * _Nonnull request, id _Nullable responseObject))success
                                    failure:(void (^_Nonnull)(OcModule * _Nonnull request, NSError * _Nullable error))failure;

@end
