//
//  GlobalInstance.h
//  SimpleApp
//
//  Created by wuyp on 2017/2/28.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalInstance : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign) NSInteger count;

@end
