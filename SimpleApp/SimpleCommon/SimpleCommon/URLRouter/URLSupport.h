//
//  URLSupport.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLInput.h"

@protocol URLSupport <NSObject>

@optional

/**
 *  一个ViewController实现此接口用来接收URL的传参
 *
 *  @param input  打开URL时的入参
 */
- (void)perpareWithURLInput:(URLInput *)input;

@end
