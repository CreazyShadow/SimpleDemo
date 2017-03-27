//
//  UIImage+Subimage.h
//  SimpleCommon
//
//  Created by wuyp on 2016/12/8.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Subimage)

@property (nonatomic, copy) NSString *name;

+ (UIImage *)subimageInRect:(UIImage *)img rect:(CGRect)rect;

@end
