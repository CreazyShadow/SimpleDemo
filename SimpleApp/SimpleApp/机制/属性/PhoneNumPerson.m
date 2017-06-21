//
//  PhoneNumPerson.m
//  SimpleApp
//
//  Created by wuyp on 2017/6/12.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "PhoneNumPerson.h"

#import <objc/runtime.h>

static void *phoneNumKey = &phoneNumKey;

@implementation PhoneNumPerson

@dynamic phoneNum;

- (NSString *)phoneNum {
    return objc_getAssociatedObject(self, phoneNumKey);
}

- (void)setPhoneNum:(NSString *)phoneNum {
    if (super.phoneNum) {
        NSLog(@"%@", super.phoneNum);
        return;
    }
    
    objc_setAssociatedObject(self, phoneNumKey, phoneNum, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
