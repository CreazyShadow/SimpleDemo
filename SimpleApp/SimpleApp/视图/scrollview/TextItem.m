//
//  TextItem.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TextItem.h"

@interface TextItem()

@property (nonatomic, strong) UILabel *lbl;

@end

@implementation TextItem

#pragma mark - init sub views

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    _lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _lbl.textAlignment = NSTextAlignmentCenter;
    _lbl.textColor = [UIColor redColor];
    _lbl.font = [UIFont systemFontOfSize:40];
    [self addSubview:_lbl];
}

- (void)render:(NSInteger)page {
    _lbl.text = [NSString stringWithFormat:@"%ld", page];
}

@end
