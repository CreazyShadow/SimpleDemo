//
//  UIView+XibMananger.h
//  SimpleApp
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XibMananger)

/**
 load the view from nib and the nib owner is self
 */
+ (id)loadFromNib;


/**
 load the view from nib

 @param nibName nib
 */
+ (id)loadFromNibWithName:(NSString *)nibName;


/**
 load the view that no owner
 */
+ (id)loadNibNoOwner;

@end
