//
//  SessionCustomProtocolConfiguration.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionCustomProtocolConfiguration : NSObject

+ (instancetype)shareManager;

- (void)openSessionProtocol;

- (void)openHttpProtocol;

@end
