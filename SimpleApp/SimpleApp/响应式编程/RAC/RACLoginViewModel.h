//
//  RACLoginViewModel.h
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/7.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"

// 1.fetch data
// 2.user change data
// 3.update model and upload to service

@interface RACLoginViewModel : NSObject

- (RACSignal<UserModel *> *)fetchData;

- (RACSignal<NSNumber *> *)loginWithUser:(UserModel *)user;

@end
