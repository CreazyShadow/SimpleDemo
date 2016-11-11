//
//  XibFileOwner.m
//  SimpleApp
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "XibFileOwner.h"

@interface XibFileOwner()

/**
 connect the xib view
 */
@property (nonatomic, weak) IBOutlet UIView *view;

@end

@implementation XibFileOwner

+ (UIView *)loadNib:(NSString *)nib {
    XibFileOwner *owner = [[XibFileOwner alloc] init];
    [[NSBundle mainBundle] loadNibNamed:nib owner:owner options:nil];
    return owner.view;
}

@end
