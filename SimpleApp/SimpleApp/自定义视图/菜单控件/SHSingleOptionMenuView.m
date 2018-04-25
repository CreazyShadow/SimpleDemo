//
//  SHSingleOptionMenuView.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/25.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "SHSingleOptionMenuView.h"

#import "SHSingleOptionMenuHeaderView.h"
#import "SHSingleOptionMenuContentView.h"

#pragma mark - entity

@implementation SHSingleOptionMenuEntity
@end

#pragma mark - SHSingleOptionMenuView

static CGFloat const kContentMaxHeight = 260;

@interface SHSingleOptionMenuView ()<SingleOptionMenuHeaderDelegate,SingleOptionMenuContentViewDelegate>

@property (nonatomic, strong) SHSingleOptionMenuHeaderView *header;
@property (nonatomic, strong) SHSingleOptionMenuContentView *content;
@property (nonatomic, strong) UIControl *maskView; ///< 蒙板

@property (nonatomic, strong) NSArray<SHSingleOptionMenuHeaderEntityModel *> *headerSource;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *contentSource;

@end

@implementation SHSingleOptionMenuView
{
    NSInteger _currentSelectedMenuIndex;
}

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        [self buildSubViews];
    }
    
    return self;
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.header = [[SHSingleOptionMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _header.delegate = self;
    [self addSubview:_header];
    
    self.maskView = [[UIControl alloc] initWithFrame:CGRectMake(0, _header.maxY, self.width, self.height)];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self addSubview:_maskView];
    
    self.content = [[SHSingleOptionMenuContentView alloc] initWithFrame:CGRectMake(0, _header.maxY, self.width, kContentMaxHeight)];
    _content.hidden = YES;
    _content.delegate = self;
    [self addSubview:_content];
}

#pragma mark - event responder

#pragma mark - public

#pragma mark - SingleOptionMenuHeaderDelegate

- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(willDisplayMenuHeaderItem:index:)]) {
        [self.delegate willDisplayMenuHeaderItem:btn index:index];
    }
}

- (SHSingleOptionMenuHeaderSelectedStyle)menuHeaderItemSelectedStyleWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menuHeaderItemSelectedStyleWithIndex:)]) {
        return [self.delegate menuHeaderItemSelectedStyleWithIndex:index];
    }
    
    return SHSingleOptionMenuHeaderSelectedDefault;
}

- (void)menuHeaderDidClickItem:(UIButton *)btn index:(NSInteger)index entity:(SHSingleOptionMenuHeaderEntityModel *)entity isCancel:(BOOL)cancel {
    _currentSelectedMenuIndex = index;
    
    //取消选中
    if (cancel) {
        self.content.hidden = YES;
        self.height = self.header.height;
        return;
    }
    
    //刷新content
    [self.content reloadData];
    
    //展现content
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat height = self.content.expectHeight > kContentMaxHeight ? kContentMaxHeight : self.content.expectHeight;
        self.content.height = height;
        self.content.hidden = NO;
        self.height = self.expandHeight;
        self.maskView.height = self.height;
    });
}

#pragma mark - SingleOptionMenuContentViewDelegate

- (NSInteger)itemCountForMenuContentView:(SHSingleOptionMenuContentView *)contentView {
    if (_currentSelectedMenuIndex >=0 && _currentSelectedMenuIndex < _contentSource.count) {
        return self.contentSource[_currentSelectedMenuIndex].count;
    }
    
    return 0;
}

- (CGSize)itemSizeForMenuContentView:(SHSingleOptionMenuContentView *)contentView index:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(itemSizeForMenuContentView:index:)]) {
        return [self.delegate itemSizeForMenu:self index:index];
    }
    
    return CGSizeMake(self.width, 40);
}

- (UIView *)menuContentView:(SHSingleOptionMenuView *)contentView itemForIndex:(NSInteger)index reusableItem:(UIView *)item itemSup:(UIView *)sup {
    UILabel *actualItem = (UILabel *)item;
    if (!item) {
        actualItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        actualItem.textColor = [UIColor orangeColor];
        actualItem.font = [UIFont systemFontOfSize:14];
        actualItem.textAlignment = NSTextAlignmentLeft;
    }
    
    actualItem.text = self.contentSource[_currentSelectedMenuIndex][index];
    return actualItem;
}

#pragma mark - private

- (void)convertHeaderAndContentSource {
    NSMutableArray *header = [NSMutableArray arrayWithCapacity:_menuSource.count];
    NSMutableArray *content = [NSMutableArray arrayWithCapacity:_menuSource.count];
    for (SHSingleOptionMenuEntity *item in _menuSource) {
        [header addObject:item.headerEntity];
        [content addObject:item.content];
    }
    
    self.headerSource = [header copy];
    self.contentSource = [content copy];
}

#pragma mark - getter & setter

- (void)setMenuSource:(NSArray<SHSingleOptionMenuEntity *> *)menuSource {
    _menuSource = [menuSource copy];
    
    // convert source
    [self convertHeaderAndContentSource];
    
    //刷新视图
    _header.optionMenuSource = _headerSource;
    
}

//- (void)setDelegate:(id<SingleOptionMenuDelegate>)delegate {
//    _delegate = delegate;
////    _header.delegate = delegate;
//}

- (void)setHeaderItemSpace:(CGFloat)headerItemSpace {
    _headerItemSpace = headerItemSpace;
    self.header.itemSpace = headerItemSpace;
}

- (void)setHeaderItemWidth:(CGFloat)headerItemWidth {
    _headerItemWidth = headerItemWidth;
    self.header.itemWidth = headerItemWidth;
}

- (void)setHeaderItemHeight:(CGFloat)headerItemHeight {
    _headerItemHeight = headerItemHeight;
    self.header.itemHeight = headerItemHeight;
}

- (void)setHeaderHorPadding:(CGFloat)headerHorPadding {
    _headerHorPadding = headerHorPadding;
    self.header.horPadding = headerHorPadding;
}

@end
