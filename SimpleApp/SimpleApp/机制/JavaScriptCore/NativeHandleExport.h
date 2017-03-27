;//
//  NativeHandleExport.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/21.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@protocol NativeHandleExport <JSExport>

- (void)login;

- (void)bindcard;

- (void)cache;

JSExportAs(cacheNamePwd,
           - (void)cacheName:(NSString *)name pwd:(NSString *)pwd);

@end
