//
//  UserModel.m
//  SimpleApp
//
//  Created by wuyp on 2018/5/13.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSString *)description {
    return [NSString stringWithFormat:@"num:%@,name:%@,password:%@", self.num, self.name, self.password];
}

+ (void)saveUser:(UserModel *)user {
    NSLog(@"********保存数据库:%@", user);
}

@end
