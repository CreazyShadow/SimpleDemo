//
//  SubView.m
//  SimpleApp
//
//  Created by wuyp on 16/11/8.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SubView.h"

@interface SubView()

@property (nonatomic, copy) NSString *name;

@end

@implementation SubView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"------- init subview");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        if (!self.name.length) {
            self.name = @"raymond";
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name {
    self = [self initWithFrame:frame];
    self.name = name;
    return self;
}

- (instancetype)initWithColor:(UIColor *)color {
    return [self initWithFrame:CGRectMake(0, 0, 200, 200)];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"-------init with coder");
    }
    return self;
}

@end
