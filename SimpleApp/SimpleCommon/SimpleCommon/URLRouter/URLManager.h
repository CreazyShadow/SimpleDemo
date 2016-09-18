//
//  URLManager.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLOpenOptions.h"
#import "URLResult.h"
#import "URLInterceptor.h"

@interface URLManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)canOpenURL:(NSString *)url;

- (void)openURL:(NSString *)url options:(URLOpenOptions *)options completion:(void (^)(URLResult *result))completion;

- (URLInterceptor *)interceptorForName:(NSString *)name;

@end
