//
//  ThridManager.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/16.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "ThridManager.h"
#import <AdhocSDK/AdhocSDK.h>

@implementation ThridManager

+ (void)initializeThridLib {
    
}

#pragma mark - adhoc

- (void)startupAdhocSDk:(NSDictionary *)launchOptions {
    AdhocSDKConfig *config = [AdhocSDKConfig defaultConfig];
    config.appKey = @"";
    config.enableDebugAssist = YES;
    config.crashTrackEnabled = YES;
    config.sessionTrackEnabled = YES;
    config.durationTrackEnabled = YES;
    [AdhocSDK startWithConfigure:config options:launchOptions];
}

@end
