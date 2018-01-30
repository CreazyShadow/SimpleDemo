//
//  SubModel.h
//  SimpleApp
//
//  Created by wuyp on 2018/1/18.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "SuperModel.h"

@interface SubModel : SuperModel

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL isBoy;

@end
