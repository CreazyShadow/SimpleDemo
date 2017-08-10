//
//  ObjectProtectedManager.h
//  SimpleCommon
//
//  Created by BYKJ on 2017/8/10.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface ObjectProtectedManager : NSObject

+ (instancetype)shareManager;

- (void)addMethod:(SEL)sel toClass:(Class)cls;

@end
