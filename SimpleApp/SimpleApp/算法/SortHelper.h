//
//  SortHelper.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/22.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSComparisonResult(^compareBlock)(id obj1, id obj2);

@interface SortHelper : NSObject

+ (NSArray *)selectSort:(NSArray *)source withCompare:(compareBlock)compare;

+ (NSArray *)quickSort:(NSArray *)source withCompare:(compareBlock)compare;

+ (NSArray *)mergerSort:(NSArray *)arr withCompareBlock:(NSComparisonResult(^)(id obj1, id obj2))block;

@end
