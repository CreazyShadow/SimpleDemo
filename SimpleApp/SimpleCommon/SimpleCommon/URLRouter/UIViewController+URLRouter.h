//
//  UIViewController+URLRouter.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class URLOpenOptions;
@class URLResult;

@interface UIViewController (URLRouter)

/**
 *  使用自己的navigationController作为额外参数来打开URL
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 */
- (void)openURL:(NSString *)url;

/**
 *  使用自己的navigationController作为额外参数来打开URL
 *
 *  @param url          带 Scheme 的 URL，如 mgj://beauty/4
 *  @param fallbackURL  被拦截后跳转到的URL
 */
- (void)openURL:(NSString *)url interceptedFallbackURL:(NSString *)fallbackURL;

/**
 *  使用自己的navigationController作为额外参数来打开URL
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param options    附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
- (void)openURL:(NSString *)url options:(URLOpenOptions *)options completion:(void (^)(URLResult *result))completion;

@end
