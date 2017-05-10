//
//  MRCObject.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "MRCObject.h"



@implementation MRCObject

- (void)print {
    NSObject *obj = [[NSObject alloc] init];
    NSObject *obj1 = obj;
    
    NSLog(@"%lu---%lu", [obj retainCount], [obj1 retainCount]);
    
    
}

@end
