//
//  YZTPageViewItem.m
//  popDemo
//
//  Created by chenlehui on 16/4/28.
//  Copyright © 2016年 chenlehui. All rights reserved.
//

#import "PageViewItem.h"

@interface PageViewItem ()

@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;

@end

@implementation PageViewItem

- (instancetype)initWithResuseIndetifier:(NSString *)reuseIdentifier {
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
    }
    return self;
}

@end
