//
//  RayMenuScrollView.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/7/18.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "RayMenuScrollView.h"

@interface RayMenuScrollView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;

@end

@implementation RayMenuScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.btnArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)setSource:(NSArray<NSString *> *)source {
    if (_source != source) {
        [_btnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_btnArray removeAllObjects];
        
        CGFloat width = MAX(self.width / source.count, 80);
        for (int i = 0; i < source.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width, self.height)];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn setTitle:source[i] forState:UIControlStateNormal];
            [self addSubview:btn];
            [_btnArray addObject:btn];
        }
        
        self.contentSize = CGSizeMake(source.count * width, 0);
    }
}

@end
