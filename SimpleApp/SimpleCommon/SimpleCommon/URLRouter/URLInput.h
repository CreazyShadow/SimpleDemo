//
//  URLInput.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class URLOpenOptions;

@interface URLInput : NSObject

/// 需要打开的URL
@property (nonatomic, strong) NSString *url;

/// URL的scheme
@property (nonatomic, strong) NSString *scheme;

/// 用来匹配Handler的pattern，一般为URL的scheme://host/path
@property (nonatomic, strong) NSString *pattern;

/// URL入参。包含从URL解析的, 和options里传来的, 已经URL解码过
@property (nonatomic, strong) NSMutableDictionary *parameters;

/// 打开URL时传入的额外参数, @see URLOpenOptions
@property (nonatomic, strong) URLOpenOptions *options;

@end
