//
//  ClassA.h
//  SimpleApp
//
//  Created by wuyp on 2017/2/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClassB.h"

@interface ClassA : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) ClassB *classB;

- (void)print;

@end
