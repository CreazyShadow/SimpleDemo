//
//  BaseView.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "BaseView.h"

@interface BaseView()

@property (nonatomic, strong) NSMutableArray<UIButton *> *headerBtns;

@end

@implementation BaseView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

#pragma mark - init sub views

- (void)initSubViews {
    [self setupHeaderBtn];
}

- (void)setupHeaderBtn {
    _headerBtns = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, -50, kScreenWidth, 50)];
    container.backgroundColor = self.backgroundColor;
    [self addSubview:container];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.opaque = YES;
        [btn setTitle:[NSString stringWithFormat:@"test%d", i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor purpleColor];
        [btn addTarget:self action:@selector(clickHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn];
        container.backgroundColor = [UIColor redColor];
        [_headerBtns addObject:btn];
    }
    
    [_headerBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.equalTo(container.mas_top).offset(0);
    }];
    [_headerBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:8 leadSpacing:0 tailSpacing:0];
}

#pragma mark - event

- (void)clickHeaderAction:(UIButton *)btn {
    if (_clickIndex) {
        _clickIndex([_headerBtns indexOfObject:btn]);
    }
}

#pragma mark - public

- (void)updateHeaderTitle:(NSString *)title index:(NSInteger)index {
    if (_headerBtns.count <= index) {
        return;
    }
    
    [_headerBtns[index] setTitle:title forState:UIControlStateNormal];
}

#pragma mark - private

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIButton *obj in _headerBtns) {
        CGRect change = [obj convertRect:obj.bounds toView:self];
        if (CGRectContainsPoint(change, point)) {
            return YES;
        }
    }
    
    return [super pointInside:point withEvent:event];;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

#pragma mark - getter & setter

@end
