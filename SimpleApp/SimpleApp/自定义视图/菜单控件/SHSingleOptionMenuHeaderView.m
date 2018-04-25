//
//  SHSingleOptionMenuView.m
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import "SHSingleOptionMenuHeaderView.h"

#define colorHex(R) [UIColor hexStringToColor:(R)]
#define kDefaultMenuColor  colorHex(@"333333")
#define kSelectedMenuColor colorHex(@"DD1712")

static NSInteger const kMenuItemBtnStartTag = 10;
static CGFloat const kItemDefaultHeight = 25;

@implementation SHSingleOptionMenuHeaderEntityModel
@end

@interface SHSingleOptionMenuHeaderView()

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) NSMutableArray<UIView *> *menuBorders;///< 包括item的border source
@property (nonatomic, strong) NSMutableArray<UIButton *> *menus;    ///< item source

@end

@implementation SHSingleOptionMenuHeaderView

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.menus = [NSMutableArray array];
        self.menuBorders = [NSMutableArray array];
        [self buildSubViews];
    }
    
    return self;
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGFloat height = [self itemHeight] ?: AdaptedWidthValue(kItemDefaultHeight);
    CGFloat width = (self.width - (_optionMenuSource.count - 1) * _itemSpace - 2 * _horPadding) / _optionMenuSource.count;
    width = _itemWidth == 0 ? width : _itemWidth;
    CGFloat height = _itemHeight == 0 ? kItemDefaultHeight : _itemHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(width * _optionMenuSource.count, 0);
    for (int i = 0; i < _menus.count && i < _menuBorders.count; i++) {
        //设置item frame
        _menuBorders[i].frame = CGRectMake(_horPadding + (width + _itemSpace) * i, (self.height - height) * 0.5, width, (self.height + height) * 0.5 + 5); // 5px为了超出父视图self
        _menus[i].frame = CGRectMake(0, 0, width, height);
        
        //调整图片位置
        if (_optionMenuSource[i].iconIsLeft) {
            [_menus[i] setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:4.f];
        } else {
            [_menus[i] setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:4.f];
        }
        
        //自定义样式
        if ([self.delegate respondsToSelector:@selector(willDisplayMenuHeaderItem:index:)]) {
            [self.delegate willDisplayMenuHeaderItem:_menus[i] index:i];
        }
    }
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
    _bottomLineView.backgroundColor = colorHex(@"F0F0F0");
    [self addSubview:_bottomLineView];
    
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    [self addSubview:_containerScrollView];
}

#pragma mark - event responder

- (void)menuItemClickAction:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    
    NSInteger selectedIndex = btn.tag - kMenuItemBtnStartTag;
    if ([self.delegate respondsToSelector:@selector(menuHeaderDidClickItem:index:entity:isCancel:)]) {
        [self.delegate menuHeaderDidClickItem:btn index:selectedIndex entity:_optionMenuSource[selectedIndex] isCancel:!btn.isSelected];
    }
    
    //设置选中后的效果
    SHSingleOptionMenuHeaderSelectedStyle selectedStyle = [self itemSelectedStyleWithIndex:btn.tag - kMenuItemBtnStartTag];
    [self renderMenuItem:btn andStyle:selectedStyle];
    
    //reset others
    for (UIButton *item in self.menus) {
        if (item.tag != btn.tag || !btn.isSelected) {
            [self resetMenuHeaderItemStatusWithIndex:item.tag - kMenuItemBtnStartTag];
            [self renderMenuItem:item andStyle:SHSingleOptionMenuHeaderSelectedDefault];
        }
    }
}

#pragma mark - public

- (void)resetMenuHeaderItemStatusWithIndex:(NSInteger)index {
    if (index < 0 || index >= self.menus.count) {
#if DEBUG
        NSParameterAssert(index > 0 && index < self.menus.count);
#endif
        return;
    }
    
    self.menus[index].selected = NO;
}

#pragma mark - private

- (void)createOptionMenuItems {
    [self.menuBorders makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menus removeAllObjects];
    
    for (int i = 0; i < _optionMenuSource.count; i++) {
        UIButton *temp = [[UIButton alloc] init];
        [temp setTitle:_optionMenuSource[i].title forState:UIControlStateNormal];
        [temp setTitleColor:kDefaultMenuColor forState:UIControlStateNormal];
        [temp setTitleColor:kSelectedMenuColor forState:UIControlStateSelected];
        [temp setImage:[UIImage imageNamed:_optionMenuSource[i].icon] forState:UIControlStateNormal];
        [temp setImage:[UIImage imageNamed:_optionMenuSource[i].selectedIcon] forState:UIControlStateSelected];
        temp.tag = kMenuItemBtnStartTag + i;
        temp.titleLabel.font = [UIFont systemFontOfSize:12];
        [temp addTarget:self action:@selector(menuItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加border view
        UIView *border = [self menuItemBorderViewWithItem:temp];
        [self.containerScrollView addSubview:border];
        
        [self.menuBorders addObject:border];
        [self.menus addObject:temp];
    }
}

- (SHSingleOptionMenuHeaderSelectedStyle)itemSelectedStyleWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menuHeaderItemSelectedStyleWithIndex:)]) {
        return [self.delegate menuHeaderItemSelectedStyleWithIndex:index];
    }
    
    return SHSingleOptionMenuHeaderSelectedDefault;
}

- (void)renderMenuItem:(UIButton *)item andStyle:(SHSingleOptionMenuHeaderSelectedStyle)style {
    
    item.layer.borderWidth = 0.f;
    self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
    self.menuBorders[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor clearColor];
    
    switch (style) {
        case SHSingleOptionMenuHeaderSelectedDefault:
            break;
            
        case SHSingleOptionMenuHeaderSelectedRedBorder:
        {
            item.layer.borderColor = colorHex(@"DD1712").CGColor;
            item.layer.borderWidth = 1.f;
        }
            break;
            
        case SHSingleOptionMenuHeaderSelectedExpand:
        {
            self.menuBorders[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor whiteColor];
            self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 1;
            self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderColor = colorHex(@"F0F0F0").CGColor;
        }
            break;
    }
}

- (UIView *)menuItemBorderViewWithItem:(UIButton *)btn {
    UIView *borderView = [[UIView alloc] init];
    [borderView addSubview:btn];
    return borderView;
}

#pragma mark - getter & setter

- (void)setOptionMenuSource:(NSArray<SHSingleOptionMenuHeaderEntityModel *> *)optionMenuSource {
    if (![optionMenuSource isKindOfClass:[NSArray class]]) {
        return;
    }
    
    _optionMenuSource = [optionMenuSource copy];
    [self createOptionMenuItems];
}

@end
