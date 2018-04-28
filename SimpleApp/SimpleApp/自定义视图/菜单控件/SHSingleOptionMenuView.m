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

#pragma mark - position indexpath

@implementation SHOptionMenuIndexPath

+ (instancetype)indexPathForHeaderIndex:(NSInteger)hIndex contentIndex:(NSInteger)cIndex {
    SHOptionMenuIndexPath *instance = [[SHOptionMenuIndexPath alloc] init];
    instance.headerIndex = hIndex;
    instance.contentIndex = cIndex;
    return instance;
}

- (BOOL)isEqual:(id)object {
    if (!object || ![object isKindOfClass:[SHOptionMenuIndexPath class]]) {
        return NO;
    }
    
    SHOptionMenuIndexPath *obj = (SHOptionMenuIndexPath *)object;
    return obj.headerIndex == self.headerIndex && obj.contentIndex == self.contentIndex;
}

@end

#pragma mark - SHSingleOptionMenuView

static CGFloat const kContentMaxHeight = 260;

@interface SHSingleOptionMenuView ()<SingleOptionMenuHeaderDelegate,SingleOptionMenuContentViewDelegate>

@property (nonatomic, strong) SHSingleOptionMenuHeaderView *header;
@property (nonatomic, strong) SHSingleOptionMenuContentView *content;
@property (nonatomic, strong) UIControl *maskView; ///< 蒙板

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<SHOptionMenuIndexPath *> *> *menuSelectedItemsCache;

@end

@implementation SHSingleOptionMenuView
{
    NSInteger _currentSelectedMenuIndex;
}

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.menuSelectedItemsCache = [[NSMutableDictionary alloc] init];
        
        [self buildSubViews];
    }
    
    return self;
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.header = [[SHSingleOptionMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:SHMenuHeaderStyleCube];
    _header.delegate = self;
    [self addSubview:_header];
    
    self.maskView = [[UIControl alloc] initWithFrame:CGRectMake(0, _header.maxY, self.width, self.height)];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_maskView addTarget:self action:@selector(maskAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maskView];
    
    self.content = [[SHSingleOptionMenuContentView alloc] initWithFrame:CGRectMake(0, _header.maxY, self.width, kContentMaxHeight)];
    _content.hidden = YES;
    _content.delegate = self;
    [self addSubview:_content];
}

#pragma mark - event responder

- (void)maskAction {
    [self setupContentStatus:NO];
}

#pragma mark - public

- (void)setupDefaultSelectedIndexPath:(NSArray<SHOptionMenuIndexPath *> *)indexPaths {
    for (SHOptionMenuIndexPath *item in indexPaths) {
        NSMutableArray *detail = [self cacheItemsForHeaderIndex:item.headerIndex];
        if (![detail containsObject:item]) {
            [detail addObject:item];
        }
    }
}

- (void)reloadMenu {
    // 创建header
    self.header.optionMenuSource = _menuHeaderSource;
    
    //创建content
    [self.content reloadData];
}

- (void)reloadHeaderItemWithTitle:(NSString *)title index:(NSInteger)index {
    [self.header reloadItemWithTitle:title index:index];
}

- (void)reloadHeaderItemWithEntity:(SHSingleOptionMenuHeaderEntityModel *)entity index:(NSInteger)index {
    [self.header reloadItemByEntity:entity index:index];
}

- (void)reloadContentItemsAtIndexs:(NSSet *)indexs {
    [self.content reloadItemsForIndexs:indexs];
}

#pragma mark - SingleOptionMenuHeaderDelegate

- (void)menuHeaderDidClickItem:(UIButton *)btn index:(NSInteger)index entity:(SHSingleOptionMenuHeaderEntityModel *)entity isChangeTab:(BOOL)isChangeTab {
    _currentSelectedMenuIndex = index;
    
    if (!self.content.hidden && !isChangeTab) { //已经展示内容 并且 点击
        [self setupContentStatus:NO];
        [self.header updateMenuItemStatus:[self hasSelectedItemForMenuHeaderIndex:index] index:index];
        return;
    }
    
    //刷新content
    [self.content reloadData];
    
    //展现content
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupContentStatus:YES];
    });
    
    if ([self.delegate respondsToSelector:@selector(menu:didSelectedHeaderItem:)]) {
        [self.delegate menu:self didSelectedHeaderItem:index];
    }
}

- (BOOL)hasSelectedItemForMenuHeaderIndex:(NSInteger)index {
    return self.menuSelectedItemsCache[@(index)].count > 0;
}

#pragma mark - SingleOptionMenuContentViewDelegate

- (NSInteger)itemCountForMenuContentView:(SHSingleOptionMenuContentView *)contentView {
    return [self.delegate menu:self numberOfContentItemsCountForHeaderIndex:_currentSelectedMenuIndex];
}

- (CGSize)itemSizeForMenuContentView:(SHSingleOptionMenuContentView *)contentView index:(NSInteger)index {
    SHOptionMenuIndexPath *indexPath = [SHOptionMenuIndexPath indexPathForHeaderIndex:_currentSelectedMenuIndex contentIndex:index];
    return [self.delegate menu:self itemSizeForIndexPath:indexPath];
}

- (UIView *)menuContentView:(SHSingleOptionMenuView *)contentView itemForIndex:(NSInteger)index reusableItem:(UIView *)item itemSup:(UIView *)sup {
    SHOptionMenuIndexPath *indexPath = [SHOptionMenuIndexPath indexPathForHeaderIndex:_currentSelectedMenuIndex contentIndex:index];
    return [self.delegate menu:self itemForIndexPath:indexPath reusableItem:item itemSup:sup];
}

- (void)menuContentView:(SHSingleOptionMenuContentView *)contentView didSelectItem:(NSInteger)index {
    SHOptionMenuIndexPath *indexPath = [SHOptionMenuIndexPath indexPathForHeaderIndex:_currentSelectedMenuIndex contentIndex:index];
    
    //修改选中的缓存
    NSMutableArray *items = [self cacheItemsForHeaderIndex:_currentSelectedMenuIndex];
    if ([items containsObject:indexPath]) {
        [items removeObject:indexPath];
    } else {
        //如果只能单选，删除以前的
        [items removeAllObjects];
        
        //如果能够多选
        
        [items addObject:indexPath];
    }
    
    //隐藏contnt
    [self setupContentStatus:NO];
    
    //更新header menu状态
    BOOL hasSelectedItem = [self hasSelectedItemForMenuHeaderIndex:_currentSelectedMenuIndex];
    [self.header updateMenuItemStatus:hasSelectedItem index:_currentSelectedMenuIndex];
    
    if ([self.delegate respondsToSelector:@selector(menu:didSelectedContentItemForIndexPath:)]) {
        [self.delegate menu:self didSelectedContentItemForIndexPath:indexPath];
    }
}

#pragma mark - private

- (void)setupContentStatus:(BOOL)isShow {
    if (!isShow) {
        self.content.hidden = YES;
        self.height = self.header.height;
        return;
    }
    
    CGFloat height = self.content.expectHeight > kContentMaxHeight ? kContentMaxHeight : self.content.expectHeight;
    self.content.height = height;
    self.content.hidden = NO;
    self.height = self.expandHeight;
    self.maskView.height = self.height;
}

- (NSMutableArray<SHOptionMenuIndexPath *> *)cacheItemsForHeaderIndex:(NSInteger)index {
    NSMutableArray *items = self.menuSelectedItemsCache[@(index)];
    if (!items) {
        items = [[NSMutableArray alloc] init];
        self.menuSelectedItemsCache[@(index)] = items;
    }
    
    return items;
}

#pragma mark - getter & setter

- (void)setMenuHeaderSource:(NSArray<SHSingleOptionMenuHeaderEntityModel *> *)menuHeaderSource {
    _menuHeaderSource = [menuHeaderSource copy];
    self.header.optionMenuSource = _menuHeaderSource;
}

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

- (NSArray<SHOptionMenuIndexPath *> *)menuSelectedItemsWithHeaderIndex:(NSInteger)index {
    return [self.menuSelectedItemsCache[@(index)] copy];
}

@end
