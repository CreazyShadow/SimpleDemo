//
//  RecyleScrollViewItem.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RecyleScrollViewItem.h"

@interface RecyleScrollViewItem()

@end

@implementation RecyleScrollViewItem

- (instancetype)initWithIdentify:(NSString *)identify {
    if (self = [super init]) {
        self.identify = identify;
    }
    
    return self;
}

@end
