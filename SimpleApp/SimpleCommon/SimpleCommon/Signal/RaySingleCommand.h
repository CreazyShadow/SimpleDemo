//
//  RaySingleCommand.h
//  SimpleCommon
//
//  Created by wuyp on 2016/12/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RaySingleCommand : NSObject

- (instancetype)initWithSource:(NSObject*)source property:(NSString *)prop singleBlock:(BOOL(^)(id source, NSString *prop))event;

@end
