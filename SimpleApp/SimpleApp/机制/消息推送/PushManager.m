//
//  PushManager.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "PushManager.h"

#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@implementation PushManager

+ (instancetype)sharePushManager {
    static PushManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PushManager alloc] init];
    });
    
    return instance;
}

- (void)registRemotePush {
    
}

- (void)registLocalPush {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"\"Fly to the moon\"";
    content.subtitle = @"by Neo";
    content.body = @"the wonderful soog with you~";
    content.badge = @0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    NSError *error = nil;
    UNNotificationAttachment *img_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    content.attachments = @[img_attachment];
    content.launchImageName = @"";//启动页
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    //设置时间间隔触发器
    UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    NSString *requestIdentifer = @"time interval request";
    content.categoryIdentifier = @"";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}















@end
