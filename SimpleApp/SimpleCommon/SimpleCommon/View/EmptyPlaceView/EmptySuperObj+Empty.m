//
//  EmptySuperObj+Empty.m
//  SimpleCommon
//
//  Created by wuyp on 2017/11/8.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "EmptySuperObj+Empty.h"
#import "NSObject+Runtime.h"

#import <objc/runtime.h>

static NSString *const kswizzleInfoPointerKey = @"pointer";
static NSMutableDictionary<NSString *, NSValue *> *_impLookupTable;

static void *kNeedExchangeKey = &kNeedExchangeKey;

@implementation EmptySuperObj (Empty)

//+ (void)load {
//    [self swizzleInstanceMethodWithOriginSel:@selector(print) swizzledSel:@selector(empty_print)];
//}

- (BOOL)needExchange {
    return [objc_getAssociatedObject(self, kNeedExchangeKey) boolValue];
}

- (void)setNeedExchange:(BOOL)needExchange {
    if (needExchange) {
        [self swizzleIfPossible:@selector(print)];
    }
    
    objc_setAssociatedObject(self, kNeedExchangeKey, [NSNumber numberWithBool:needExchange], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)empty_print {
    NSLog(@"----- empty obj print");
}

void ray_original_implementation(id self, SEL _cmd) {
    NSValue *impValue = [_impLookupTable objectForKey:kswizzleInfoPointerKey];
    IMP impPointer = [impValue pointerValue];
    
    [self empty_print];
    
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

- (void)swizzleIfPossible:(SEL)selector {
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    if (!_impLookupTable) {
        _impLookupTable = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    
    Method method = class_getInstanceMethod([self class], selector);
    IMP newImp = method_setImplementation(method, (IMP)ray_original_implementation);
    [_impLookupTable setObject:[NSValue valueWithPointer:newImp] forKey:kswizzleInfoPointerKey];
}

@end
