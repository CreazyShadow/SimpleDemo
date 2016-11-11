//
//  XibFileOwner.h
//  SimpleApp
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 please set the xib file owner is this
 */
@interface XibFileOwner : NSObject

+ (UIView *)loadNib:(NSString *)nib;

@end
