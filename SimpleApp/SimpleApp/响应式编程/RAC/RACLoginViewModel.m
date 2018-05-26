//
//  RACLoginViewModel.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/7.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "RACLoginViewModel.h"

@interface RACLoginViewModel ()

@end

@implementation RACLoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;   
}

- (RACSignal<UserModel *> *)fetchData {
    RACSignal *single = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UserModel *user = [[UserModel alloc] init];
            user.num = @"0";
            user.name = @"raymond";
            user.password = @"123456";
            
            [subscriber sendNext:user];
        });
        return [[RACDisposable alloc] init];
    }];
    
    return single;
}

- (RACSignal<NSNumber *> *)loginWithUser:(UserModel *)user {
    RACSignal *single = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@(YES)];
        });
        
        // save to db
        [UserModel saveUser:user];
        
        return [[RACDisposable alloc] init];
    }];
    
    return single;
}

@end
