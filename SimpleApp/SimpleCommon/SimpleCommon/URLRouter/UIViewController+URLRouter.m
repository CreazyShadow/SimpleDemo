//
//  UIViewController+URLRouter.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "UIViewController+URLRouter.h"
#import "URLOpenOptions.h"
#import "URLResult.h"
#import "URLRouter.h"
#import "URLLog.h"

@implementation UIViewController (URLRouter)

- (void)openURL:(NSString *)url {
    [self openURL:url options:nil completion:nil];
}

- (void)openURL:(NSString *)url interceptedFallbackURL:(NSString *)fallbackURL {
    URLOpenOptions *options = [URLOpenOptions new];
    options.interceptedFallbackURL = fallbackURL;
    [self openURL:url options:options completion:nil];
}

- (void)openURL:(NSString *)url options:(URLOpenOptions *)options completion:(void (^)(URLResult *))completion {
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    if (!options) {
        options = [URLOpenOptions new];
    }
    
    if (!options.sourceViewController) {
        options.sourceViewController = self;
    }
    
    [URLRouter openURL:url options:options completion:completion];
    URLLog(@"open url: %@, duration: %f", url, [NSDate timeIntervalSinceReferenceDate] - start);
}

@end
