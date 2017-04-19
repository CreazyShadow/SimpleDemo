//
//  ClassicsArithmetic.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/24.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassicsArithmetic : NSObject

/**
 @param total 总人数
 @param range 间隔人数 当间隔为0时range：1 当间隔为1时，range：2
 @return 最后一个人原始的位置
 */
+ (NSInteger)selectedIndexWithTotalCount:(NSInteger)total range:(NSInteger)range;

@end
