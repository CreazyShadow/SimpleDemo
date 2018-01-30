//
//  Person.h
//  SimpleModel
//
//  Created by wuyp on 16/8/19.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseModel.h"

@protocol Optional <NSObject>

@end

@interface Person : BaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phoneNum;

@property (nonatomic, assign) BOOL isBoy;

- (void)test;

@end
