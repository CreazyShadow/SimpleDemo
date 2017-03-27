//
//  PushManager.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushManager : NSObject

+ (instancetype)sharePushManager;

- (void)registRemotePush;

- (void)registLocalPush;

@end
