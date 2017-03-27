//
//  ClassB.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ClassB.h"

@implementation ClassB

- (void)print {
    NSLog(@"----class B");
    
//    [self print];
    ClassB *b = [[ClassB alloc] init];
    [b print];
}

@end
