//
//  NatureClass.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/16.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "NatureClass.h"

@implementation NatureClass

- (void)testNature {
    NatureClass *obj = [[NatureClass alloc] init];
    obj->_no = 4;
    obj->_age = 5;
    
    NSLog(@"class size:%zd,%zd, obj size:%lu", class_getInstanceSize([NSObject class]), class_getInstanceSize([NatureClass class]), sizeof(obj));
}

@end
