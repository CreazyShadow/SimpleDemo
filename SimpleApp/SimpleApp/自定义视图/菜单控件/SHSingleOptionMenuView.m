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
#import "AppDelegate.h"

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
@property (nonatomic, strong) UIControl *maskView;  ///< 蒙板

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<SHOptionMenuIndexPath *> *> *menuSelectedItemsCache;
@property (nonatomic, assign) SHSingleOptionMenuStyle style;

@end

@implementation SHSingleOptionMenuView
{
    NSInteger _currentSelectedMenuIndex;
}

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame style:(SHSingleOptionMenuStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.menuSelectedItemsCache = [[NSMutableDictionary alloc] init];
        self.style = style;
        
        [self buildSubViews];
    }
    
    return self;
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.header = [[SHSingleOptionMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:(SHMenuHeaderStyle)_style];
    _header.delegate = self;
    [self addSubview:_header];
    
    self.maskView = [[UIControl alloc] initWithFrame:CGRectMake(0, _header.bottom, self.width, self.height)];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_maskView addTarget:self action:@selector(maskAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maskView];
    
    self.content = [[SHSingleOptionMenuContentView alloc] initWithFrame:CGRectMake(0, _header.bottom, self.width, kContentMaxHeight)];
    _content.hidden = YES;
    _content.delegate = self;
    [self addSubview:_content];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _content.bottom, self.width, 44)];
    [self addSubview:_bottomView];
    
    self.resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _bottomView.width * 0.5, _bottomView.height)];
    [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [_resetBtn setTitleColor:colorHex(@"666666") forState:UIControlStateNormal];
    _resetBtn.backgroundColor = colorHex(@"F7F7F7");
    _resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_resetBtn];
    
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(_resetBtn.right, 0, _bottomView.width * 0.5, _bottomView.height)];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:colorHex(@"FFFFFF") forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = [UIColor redColor];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_confirmBtn];
}

#pragma mark - event responder

- (void)maskAction {
    [self setupContentStatus:NO];
}

- (void)resetAction {
    NSMutableArray *items = [self cacheItemsForHeaderIndex:_currentSelectedMenuIndex];
    [items removeAllObjects];
    
    //刷新界面
    [self.content reloadData];
    
    if ([self.delegate respondsToSelector:@selector(menu:didClickBottomAction:index:)]) {
        [self.delegate menu:self didClickBottomAction:NO index:_currentSelectedMenuIndex];
    }
}

- (void)confirmAction {
    [self changeUIWhenSelectedContentItems];
    
    if ([self.delegate respondsToSelector:@selector(menu:didClickBottomAction:index:)]) {
        [self.delegate menu:self didClickBottomAction:YES index:_currentSelectedMenuIndex];
    }
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

- (void)resetMenu {
    // reset header
    [self.header reloadItems];
    
    // reset content
    [self.menuSelectedItemsCache removeAllObjects];
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

- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menu:willDisplayHeaderItem:index:)]) {
        [self.delegate menu:self willDisplayHeaderItem:btn index:index];
    }
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
    
    //是否能够多选
    BOOL canMulti = [self canMultiChoiceForHeaderIndex:_currentSelectedMenuIndex];
    
    //修改选中的缓存
    NSMutableArray *items = [self cacheItemsForHeaderIndex:_currentSelectedMenuIndex];
    if ([items containsObject:indexPath]) {
        [items removeObject:indexPath];
    } else {
        if (!canMulti) { //单选
            [items removeAllObjects];
        }
        
        [items addObject:indexPath];
    }
    
    //隐藏contnt
    if (!canMulti) {
        [self changeUIWhenSelectedContentItems];
    }
    
    if ([self.delegate respondsToSelector:@selector(menu:didSelectedContentItemForIndexPath:)]) {
        [self.delegate menu:self didSelectedContentItemForIndexPath:indexPath];
    }
}

#pragma mark - private

- (void)setupContentStatus:(BOOL)isShow {
    if (!isShow) {
        self.bottomView.hidden = YES;
        self.content.hidden = YES;
        self.height = self.header.height;
        return;
    }
    
    CGFloat height = self.content.expectHeight > kContentMaxHeight ? kContentMaxHeight : self.content.expectHeight;
    self.content.height = height;
    self.bottomView.top = _content.bottom;
    self.content.hidden = NO;
    self.bottomView.hidden = ![self canMultiChoiceForHeaderIndex:_currentSelectedMenuIndex];
    UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    CGRect rect = [self convertRect:self.bounds toView:window];
    self.height = kScreenHeight - rect.origin.y;
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

- (BOOL)canMultiChoiceForHeaderIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menu:canMulSelectedForHeaderIndex:)]) {
        return [self.delegate menu:self canMulSelectedForHeaderIndex:index];
    }
    
    return NO;
}

- (void)changeUIWhenSelectedContentItems {
    [self setupContentStatus:NO];
    
    //更新header menu状态
    BOOL hasSelectedItem = [self hasSelectedItemForMenuHeaderIndex:_currentSelectedMenuIndex];
    [self.header updateMenuItemStatus:hasSelectedItem index:_currentSelectedMenuIndex];
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
