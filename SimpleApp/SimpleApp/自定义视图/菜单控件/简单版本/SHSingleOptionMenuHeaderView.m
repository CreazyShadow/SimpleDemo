//
//  SHSingleOptionMenuView.m
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import "SHSingleOptionMenuHeaderView.h"

#define kDefaultMenuColor  colorHex(@"333333")
#define kSelectedMenuColor colorHex(@"DD1712")

static NSInteger const kMenuItemBtnStartTag = 10;
static CGFloat const kItemDefaultHeight = 25;

@interface SHSingleOptionMenuHeaderView()

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, assign) SHMenuHeaderStyle style;

@property (nonatomic, strong) NSMutableArray<SHSingleOptionMenuHeaderItemView *> *itemsArray;    ///< item source
@property (nonatomic, strong) NSMutableDictionary<NSString *, SHSingleOptionMenuHeaderItemView *> *lastItemPool;

@end

@implementation SHSingleOptionMenuHeaderView
{
	BOOL _isFirstCreate;
}

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame style:(SHMenuHeaderStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.itemsArray = [NSMutableArray array];
        self.style = style;
        _isFirstCreate = YES;
        
        [self buildSubViews];
    }
    
    return self;
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = [self.delegate numberOfItemsCountInHeader:self];
    if (count == 0) {
        return;
    }
    
    //创建items
    if (_isFirstCreate) {
        [self createOptionMenuItems];
        _isFirstCreate = NO;
    }
    
    //更新布局
    CGFloat width = (self.width - (count - 1) * _itemSpace - 2 * _horPadding) / count;
    width = _itemWidth == 0 ? width : _itemWidth;
    CGFloat height = self.height;
    
    self.containerScrollView.contentSize = CGSizeMake(width * count, 0);
    for (int i = 0; i < _itemsArray.count; i++) {
        //设置item frame
        _itemsArray[i].frame = CGRectMake(_horPadding + (width + _itemSpace) * i, 0, width, height);
        _itemsArray[i].titleHeight = self.itemHeight > 0 ? self.itemHeight : kItemDefaultHeight;
        
        //自定义样式
        if ([self.delegate respondsToSelector:@selector(willDisplayMenuHeader:item:index:)]) {
            [self.delegate willDisplayMenuHeader:self item:_itemsArray[i] index:i];
        }
    }
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    _bottomLineView.backgroundColor = [UIColor redColor];
    [self addSubview:_bottomLineView];
    
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_containerScrollView];
}

#pragma mark - event responder

- (void)menuItemClickAction:(SHSingleOptionMenuHeaderItemView *)btn {
    NSInteger selectedIndex = btn.tag - kMenuItemBtnStartTag;
    SHSingleOptionMenuHeaderItemView *lastItem = self.lastItemPool[btn.model.group];
    BOOL isChangeTab = [self itemShouldChangeStatusWithLast:lastItem current:btn];
    if (isChangeTab) {
        lastItem.status = SHMenuHeaderItemStateDefault;
        lastItem.backgroundColor = [UIColor clearColor];
    }
    
    btn.backgroundColor = _style == SHMenuHeaderStylePlainText ? [UIColor clearColor] : self.backgroundColor;
    btn.status = SHMenuHeaderItemStateSelecting;
    self.lastItemPool[btn.model.group] = btn;
    
    if ([self.delegate respondsToSelector:@selector(menuHeader:didClickItem:index:isChangeTab:)]) {
        [self.delegate menuHeader:self didClickItem:btn index:selectedIndex isChangeTab:isChangeTab];
    }
}

#pragma mark - public

- (void)reloadItems {
    [self.lastItemPool removeAllObjects];
    [self createOptionMenuItems];
}

- (void)reloadItemsWithIndexs:(NSSet<NSNumber *> *)indexs {
    for (NSNumber *temp in indexs) {
        NSInteger index = temp.integerValue;
        if (index < 0 || index >= self.itemsArray.count) {
            continue;
        }
        
        SHOptionMenuHeaderItemEntityModel *model = [self.delegate itemEntityModelForIndex:index inHeader:self];
        self.itemsArray[index].model = model;
        
        //自定义样式
        if ([self.delegate respondsToSelector:@selector(willDisplayMenuHeader:item:index:)]) {
            [self.delegate willDisplayMenuHeader:self item:_itemsArray[index] index:index];
        }
    }
}

- (void)updateMenuItemStatus:(BOOL)status index:(NSInteger)index {
    if (index < 0 || index >= self.itemsArray.count) {
        return;
    }
    
    SHSingleOptionMenuHeaderItemView *item = self.itemsArray[index];
    item.status = !status ? SHMenuHeaderItemStateDefault : SHMenuHeaderItemStateSelected;
    item.backgroundColor = item.status == SHMenuHeaderItemStateSelecting ? self.backgroundColor : [UIColor clearColor];
    if (_style != SHMenuHeaderStyleCube) {
        self.lastItemPool[item.model.group] = item;
    }
}

#pragma mark - private

- (void)createOptionMenuItems {
    [self.itemsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.itemsArray removeAllObjects];
    
    NSInteger count = [self.delegate numberOfItemsCountInHeader:self];
    SHOptionMenuHeaderItemStyle itemStyle = (SHOptionMenuHeaderItemStyle)self.style;
    for (int i = 0; i < count; i++) {
        SHSingleOptionMenuHeaderItemView *temp = [[SHSingleOptionMenuHeaderItemView alloc] initWithFrame:CGRectZero style:itemStyle];
        temp.tag = kMenuItemBtnStartTag + i;
        temp.model = [self.delegate itemEntityModelForIndex:i inHeader:self];
        temp.status = SHMenuHeaderItemStateDefault;
        [temp addTarget:self action:@selector(menuItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.containerScrollView addSubview:temp];
        [self.itemsArray addObject:temp];
    }
    
    //设置默认选中
    __weak SHSingleOptionMenuHeaderView *weakSelf = self;
    [self.defaultSelectedItems enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < weakSelf.itemsArray.count) {
            SHSingleOptionMenuHeaderItemView *item = weakSelf.itemsArray[idx];
            weakSelf.lastItemPool[item.model.group] = item;
        }
    }];
    
    [self.lastItemPool enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SHSingleOptionMenuHeaderItemView * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.status = SHMenuHeaderItemStateSelected;
    }];
    
    [self setNeedsLayout];
}

- (BOOL)itemShouldChangeStatusWithLast:(SHSingleOptionMenuHeaderItemView *)last current:(SHSingleOptionMenuHeaderItemView *)current {
    if (last.tag == current.tag || !last) {
        return NO;
    }
    
    if (last.model.group.length == 0 || current.model.group.length == 0) {
        return NO;
    }
    
    return [last.model.group isEqualToString:current.model.group];
}

#pragma mark - change item ui

#pragma mark - getter & setter

- (NSMutableDictionary<NSString *,SHSingleOptionMenuHeaderItemView *> *)lastItemPool {
    if (!_lastItemPool) {
        _lastItemPool = [[NSMutableDictionary alloc] init];
    }
    
    return _lastItemPool;
}

@end
