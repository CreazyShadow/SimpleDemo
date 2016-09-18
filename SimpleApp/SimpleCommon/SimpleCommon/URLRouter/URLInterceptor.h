//
//  URLInterceptor.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLInput.h"
#import "URLResult.h"

@protocol URLInterceptor <NSObject>

@optional

/**
 *  执行前拦截，返回YES表示中断后续处理
 *
 *  @param input      输入参数
 *  @param completion 完成后处理
 *
 *  @return 是否继续打开URL
 */
- (BOOL)shouldOpenURLWithInput:(URLInput *)input completion:(void(^)(URLResult *result))completion;

/**
 *  执行后处理
 *
 *  @param input  输入参数
 *  @param result OpenURL的结果
 *
 *  @return 处理结果
 */
- (URLResult *)didOpenURLWithInput:(URLInput *)input result:(URLResult *)result;

@end

/**
 *  用来拦截URLRouter的block操作，实现简单的面向切片的功能
 */
@interface URLInterceptor : NSObject<URLInterceptor>

/**
 *  拦截器的名字，可用来调试
 */
@property (nonatomic, strong) NSString *name;
/**
 *  顺序，用于多个interceptor排序
 */
@property (nonatomic, strong) NSString *sort;

/**
 *  检查当前拦截器是否匹配一个URL
 *
 *  @param input 待匹配的参数
 *
 *  @return 是否匹配
 */
- (BOOL)isMatchURLWithInput:(URLInput *)input;

/**
 *  protected method. used for subclass
 */
- (void)interceptWithURL:(NSString *)url
           originalInput:(URLInput *)originalInput
      originalCompletion:(void(^)(URLResult *result))originalCompletion;

@end
