//
//  URLHandler.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLOpenOptions.h"
@class URLInput;
@class URLResult;

extern NSString * const URLOpenActionPush;
extern NSString * const URLOpenActionPresent;

@protocol URLHandler <NSObject>

/**
 *  打开URL
 *
 *  @param input 输入参数
 *  @param completion 完成的回调
 */
- (void)openURLWithInput:(URLInput *)input completion:(void (^)(URLResult *result))completion;

@optional

/**
 *  处理URL
 */
@property (nonatomic, copy) NSString *url;

@end

/**
 *  Handler用来处理具体的URL请求
 *
 *  @descussion 每次请求会创建一个Handler,处理完即被释放。
 *  如需长久存在以接受回调或做其他后续处理，请设置owner属性。
 *  owner为一个在后续处理结束前可以持有Handler的对象，比如说sourceViewController。
 *  
 *  @note handler不应该直接或间接的持有任何ViewController对象
 */
@interface URLHandler : NSObject <URLHandler>

/**
 *  Handler的名字，可用来调试
 */
@property (nonatomic, copy) NSString *name;

/**
 *  此处理器可用来处理URL
 */
@property (nonatomic, copy) NSString *url;

/**
 *  动作方式，push/present
 */
@property (nonatomic, copy) NSString *action;

/**
 *  此处可设置重定向的URL
 */
@property (nonatomic, copy) NSString *redirectURL;

/**
 *  将要打开的ViewController类名
 */
@property (nonatomic, copy) NSString *viewController;

@property (nonatomic, readonly, strong) NSDictionary *viewProperties;

/**
 *  添加一个参数到viewProperties中
 */
- (void)setViewProperty:(id)object forKey:(NSString *)key;

/**
 *  protected method. for retain self
 *  @discussion 该属性用于需要handler响应回调时保证handler不会被释放
 */
@property (nonatomic, weak) id owner;

- (void)openViewController:(UIViewController *)viewController
                 withInput:(URLInput *)input
                completion:(void(^)(URLResult *result))completion;

@end
