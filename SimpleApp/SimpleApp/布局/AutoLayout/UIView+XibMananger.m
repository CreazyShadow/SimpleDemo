//
//  UIView+XibMananger.m
//  SimpleApp
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "UIView+XibMananger.h"
#import "XibFileOwner.h"

@implementation UIView (XibMananger)

+ (id)loadFromNib {
    return [self loadFromNibWithName:NSStringFromClass(self)];
}

+ (id)loadFromNibWithName:(NSString *)nibName {
    return [XibFileOwner loadNib:nibName];
}

+ (id)loadNibNoOwner {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
