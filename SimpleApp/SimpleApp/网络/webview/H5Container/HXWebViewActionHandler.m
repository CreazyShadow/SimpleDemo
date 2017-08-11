//
//  HXWebViewActionHandler.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewActionHandler.h"

#import <WKWebViewJavascriptBridge.h>

#import <objc/runtime.h>
#import <objc/message.h>

@interface HXWebViewActionHandler()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *h5SharedDataPool;

@end

@implementation HXWebViewActionHandler

- (instancetype)init {
    if (self = [super init]) {
        self.h5SharedDataPool = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)excute {
    unsigned int count = 0;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL sel = method_getName(methods[i]);
        NSString *selName = NSStringFromSelector(sel);
        if ([selName hasPrefix:@"js_"]) {
            ((void(*)(id,SEL))objc_msgSend)(self, sel);
        }
    }
}

- (id)jsResponseDataForHandler:(NSString *)handler {
    return self.h5SharedDataPool[handler];
}

- (void)cacheH5ResponseData:(NSString *)handlerName reponse:(id)data {
    if (!data || !handlerName) {
        return;
    }
    
    [self.h5SharedDataPool setObject:data forKey:handlerName];
}

@end
