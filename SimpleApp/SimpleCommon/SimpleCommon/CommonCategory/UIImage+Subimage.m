//
//  UIImage+Subimage.m
//  SimpleCommon
//
//  Created by wuyp on 2016/12/8.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "UIImage+Subimage.h"

#import <objc/runtime.h>

@implementation UIImage (Subimage)

@dynamic name;

+ (UIImage *)subimageInRect:(UIImage *)img rect:(CGRect)rect {
   CGImageRef temp = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage *new = [UIImage imageWithCGImage:temp];
    return new;
}

@end
