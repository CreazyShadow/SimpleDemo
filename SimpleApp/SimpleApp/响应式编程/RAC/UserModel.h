//
//  UserModel.h
//  SimpleApp
//
//  Created by wuyp on 2018/5/13.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;

+ (void)saveUser:(UserModel *)user;

@end
