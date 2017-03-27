//
//  SortHelper.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/22.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortHelper : NSObject

+ (NSArray *)mergerSort:(NSArray *)arr withCompareBlock:(NSComparisonResult(^)(id obj1, id obj2))block;

@end
