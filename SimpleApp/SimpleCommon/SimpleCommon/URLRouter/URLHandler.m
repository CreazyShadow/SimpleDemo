//
//  URLHandler.m
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "URLHandler.h"
#import "URLRouter.h"
#import "URLSupport.h"
#import "NSError+URLRouter.h"
#import "URLLog.h"
#import "URLResult.h"
#import <objc/runtime.h>

static int kURLHandlerKey;

@interface URLHandler()

@property (nonatomic, strong) NSDictionary *viewProperties;

@end

@implementation URLHandler

#pragma mark - YYModel

+ (Class)modelCustomClassForDictionary:(NSDictionary *)dic {
    NSString *className = dic[@"class"];
    if (className.length > 0) {
        Class clz = NSClassFromString(className);
        if (clz) {
            return clz;
        }
    }
    
    return self.class;
}

#pragma mark - life cycle

- (void)dealloc {
    URLLog(@"handler dealloc: %@, %@", self, self.url);
}

#pragma mark - public

- (void)openURLWithInput:(URLInput *)input completion:(void (^)(URLResult *))completion {
    if (self.redirectURL) {
        URLOpenOptions *options = input.options ? : [URLOpenOptions new];
        if (!options.sourceURL) {
            options.sourceURL = input.url;
        }
        
        [URLRouter openURL:self.redirectURL options:options completion:completion];
        return;
    }
    
    Class clz = NSClassFromString(self.viewController);
    if (clz == nil) {
        if (completion) {
            completion([URLResult errorResultWithInput:input message:[NSString stringWithFormat:@"class not found:%@", self.viewController]]);
        }
        
        return;
    }
    
    UIViewController *vc = [[clz alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    if (vc == nil) {
        if (completion) {
            completion([URLResult errorResultWithInput:input message:[NSString stringWithFormat:@"creating viewcontroller failed:%@", self.viewController]]);
        }
        
        return;
    }
    
    if ([vc respondsToSelector:@selector(prepareWithURLInput:)]) {
        [(id<URLSupport>)vc perpareWithURLInput:input];
    }
    
    NSDictionary *vps = input.options.viewProperties;
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    if (self.viewProperties.count > 0) {
        [properties addEntriesFromDictionary:self.viewProperties];
    }
    
    if (vps.count > 0) {
        [properties addEntriesFromDictionary:vps];
    }
    
    if (properties.count > 0) {
        @try {
            [properties enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [vc setValue:obj forKey:key];
            }];
        } @catch (NSException *exception) {
            if (completion) {
                completion([URLResult resultWithInput:input source:nil destination:vc error:[NSError errorWithURLException:exception]]);
            }
            
            return;
        } @finally {
        }
    }
    
    UIViewController *sourceVC = input.options.sourceViewController;
    UIViewController *oldVC= vc;
    if (input.options.perparation) {
        __weak typeof(input) winput = input;
        vc = input.options.perparation(sourceVC, vc, input);
    }
    
    if (!vc) {
        if (completion) {
            completion([URLResult errorResultWithInput:input message:[NSString stringWithFormat:@"perparation cancelled:%@", oldVC]]);
        }
        
        return;
    }
    
    [self openViewController:vc withInput:input completion:completion];
}

- (void)openViewController:(UIViewController *)viewController withInput:(URLInput *)input completion:(void (^)(URLResult *))completion {
    if (!viewController) {
        if (completion) {
            completion([URLResult errorResultWithInput:input message:[NSString stringWithFormat:@"destination viewController null!"]]);
        }
        
        return;
    }
    
    UIViewController *sourceVC = input.options.sourceViewController;
    NSString *action = input.options.acton ? : self.action;
    if (action == nil) {
        action = URLOpenActionPush;
    }
    
    BOOL animated = input.options ? input.options.animated : YES;
    if ([action isEqualToString:URLOpenActionPush]) {
        UINavigationController *nav = nil;
        
        // check if tabbar
        if ([sourceVC isKindOfClass:[UITabBarController class]]) {
            nav = (UINavigationController *)[(UITabBarController *)sourceVC selectedViewController];
        }
        
        // check normal source
        if (!nav) {
            nav = [sourceVC isKindOfClass:[UINavigationController class]] ? (UINavigationController *)sourceVC : sourceVC.navigationController;
        }
        
        // check root
        if (!nav) {
            UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            if ([tab isKindOfClass:[UINavigationController class]]) {
                tab = [(UINavigationController *)tab viewControllers].firstObject;
            }
            if ([tab isKindOfClass:[UITabBarController class]]) {
                nav = [tab.selectedViewController isKindOfClass:[UINavigationController class]] ? tab.selectedViewController : nil;
            }
        }
        
        NSError *error = nil;
        if (nav) {
            [nav pushViewController:viewController animated:animated];
        } else {
            error = [NSError errorWithDomain:URLErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Can't find navigation controller"}];
        }
        
        if (completion) {
            completion([URLResult resultWithInput:input source:sourceVC ?: nav destination:viewController error:error]);
        }
    } else if ([action isEqualToString:URLOpenActionPresent]) {
        UIViewController *presentingViewController = sourceVC ?: [UIApplication sharedApplication].delegate.window.rootViewController;
        if (![viewController isKindOfClass:[UINavigationController class]] && ![viewController isKindOfClass:[UITabBarController class]]) {
            viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        [presentingViewController presentViewController:viewController animated:animated completion:^{
            if (completion) {
                completion([URLResult resultWithInput:input source:presentingViewController destination:viewController error:nil]);
            }
        }];
    } else {
        if (completion) {
            completion([URLResult errorResultWithInput:input message:[NSString stringWithFormat:@"Unsupported action: %@", action]]);
        }
    }
}

#pragma mark - getter & setter

- (void)setViewProperty:(id)object forKey:(NSString *)key {
    NSMutableDictionary *params = nil;
    if ([self.viewProperties isKindOfClass:[NSMutableDictionary class]]) {
        params = (NSMutableDictionary *)self.viewProperties;
    } else {
        params = [NSMutableDictionary dictionary];
        if (self.viewProperties.count > 0) {
            [params addEntriesFromDictionary:self.viewProperties];
        }
    }
    
    if (object) {
        params[key] = object;
    } else {
        [params removeObjectForKey:key];
    }
    
    self.viewProperties = params;
}

//???: 不懂
- (void)setOwner:(id)owner {
    if (_owner != owner) {
        if (_owner) {
            objc_setAssociatedObject(_owner, &kURLHandlerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        _owner = owner;
        if (_owner) {
            objc_setAssociatedObject(_owner, &kURLHandlerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

@end
