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

@implementation HXWebViewActionHandler

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

- (void)js_share {
    NSLog(@"----1");
}

- (void)js_login {
    NSLog(@"----2");
}

- (void)js_openAccount {
    NSLog(@"----3");
}

@end
