//
//  SHIndexMenuView.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/10.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "SHIndexMenuView.h"

@interface SHIndexMenuView ()

@property (nonatomic, strong) NSMutableArray<UILabel *> *indexSource;

@end

@implementation SHIndexMenuView

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = _itemH > 0 ? _itemH : self.height / _indexSource.count;
    CGFloat width = self.width;
    CGFloat startMargin = (self.height - _indexSource.count * height) * 0.5;
    for (int i = 0; i < _indexSource.count; i++) {
        _indexSource[i].textColor = _itemColor;
        _indexSource[i].font = _itemFont;
        _indexSource[i].frame = CGRectMake(0, startMargin + i * height, width, height);
    }
}

#pragma mark - event responder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_indexSource.count == 0) {
        return;
    }
    
    CGPoint point = [touches.anyObject locationInView:self];
    NSInteger selectedIndex = [self itemIndexForTouchPoint:point];
    NSLog(@"begin-选中---%ld", selectedIndex);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_indexSource.count == 0) {
        return;
    }
    
    CGPoint point = [touches.anyObject locationInView:self];
    NSInteger selectedIndex = [self itemIndexForTouchPoint:point];
    NSLog(@"move-选中---%ld", selectedIndex);
}

#pragma mark - public

#pragma mark - private

- (void)createItemsWithSource:(NSArray<NSString *> *)indexTitles {
    [self.indexSource makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.indexSource = [[NSMutableArray alloc] initWithCapacity:indexTitles.count];
    
    for (int i = 0; i < indexTitles.count; i++) {
        UILabel *item = [[UILabel alloc] init];
        item.textAlignment = NSTextAlignmentCenter;
        item.text = indexTitles[i];
        [self addSubview:item];
        [_indexSource addObject:item];
    }
}

- (NSInteger)itemIndexForTouchPoint:(CGPoint)point {
    if (_indexSource.count < 2 || _indexSource[0].top >= point.y) {
        return 0;
    }
    
    if (_indexSource.lastObject.top <= point.y) {
        return _indexSource.count - 1;
    }
    
    for (int i = 0; i < _indexSource.count; i++) {
        if (CGRectContainsPoint(_indexSource[i].frame, point)) {
            return i;
        }
    }
    
    return 0;
}

#pragma mark - getter & setter

- (void)setIndexTitlesArray:(NSArray<NSString *> *)indexTitlesArray {
    _indexTitlesArray = [indexTitlesArray copy];
    
    [self createItemsWithSource:_indexTitlesArray];
}

@end
