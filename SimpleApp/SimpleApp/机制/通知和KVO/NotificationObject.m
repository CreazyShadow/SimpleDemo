//
//  NotificationObject.m
//  SimpleApp
//
//  Created by wuyp on 2017/5/2.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "NotificationObject.h"

@implementation NotificationObject

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}

- (void)setPhone:(NSString *)phone {

}

@end
