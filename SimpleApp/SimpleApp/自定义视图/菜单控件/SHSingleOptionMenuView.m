//
//  SHSingleOptionMenuView.m
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import "SHSingleOptionMenuView.h"

static const NSInteger kRowItemsCount     = 4;
//#define kDefaultMenuColor  colorHex(@"333333")
//#define kSelectedMenuColor colorHex(@"DD1712")
#define colorHex(R) [UIColor hexStringToColor:R]
#define kDefaultMenuColor  colorHex(@"333333")
#define kSelectedMenuColor colorHex(@"DD1712")

static NSInteger const kMenuItemBtnStartTag = 10;

static CGFloat const kItemDefaultHeight = 25;


@implementation SHSingleOptionMenuEntityModel
@end

@interface SHSingleOptionMenuView()

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) NSMutableArray<UIView *> *menuBorders;///< 包括item的border source
@property (nonatomic, strong) NSMutableArray<UIButton *> *menus;    ///< item source

@end

@implementation SHSingleOptionMenuView

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
    
    
    CGFloat space = [self itemSpace];
    CGFloat margin = [self menuPadding];
//    CGFloat height = [self itemHeight] ?: AdaptedWidthValue(kItemDefaultHeight);
    CGFloat height = [self itemHeight];
    CGFloat width = (self.width - (_optionMenuSource.count - 1) * space - 2 * margin) / kRowItemsCount;
    self.containerScrollView.contentSize = CGSizeMake(width * _optionMenuSource.count, 0);
    
    for (int i = 0; i < _menus.count && i < _menuBorders.count && i < _optionMenuSource.count; i++) {
        _menuBorders[i].frame = CGRectMake(margin + (width + space) * i, (self.height - height) * 0.5, width, (self.height + height) * 0.5 + 5); // 5px为了超出父视图self
        _menus[i].frame = CGRectMake(0, 0, width, height);
        
        //调整图片位置
        if (_optionMenuSource[i].iconIsRight) {
            [_menus[i] setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:2.f];
        } else {
            [_menus[i] setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:2.f];
        }
        
        if ([self.delegate respondsToSelector:@selector(willDisplayMenuItem:index:)]) {
            [self.delegate willDisplayMenuItem:_menus[i] index:i];
        }
    }
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_containerScrollView];
}

#pragma mark - event responder

- (void)menuItemClickAction:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    
    NSInteger selectedIndex = btn.tag - kMenuItemBtnStartTag;
    if ([self.delegate respondsToSelector:@selector(didSelectedMenuItem:index:entity:)]) {
        [self.delegate didSelectedMenuItem:btn index:selectedIndex entity:_optionMenuSource[selectedIndex]];
    }
    
    //设置选中后的效果
    SHSingleOptionMenuSelectedStyle selectedStyle = [self itemSelectedStyleWithIndex:btn.tag - kMenuItemBtnStartTag];
    [self renderMenuItem:btn andStyle:selectedStyle];
    
    //reset others
    for (UIButton *item in self.menus) {
        if (item.tag != btn.tag || !btn.isSelected) {
            [self resetMenuItemStatusWithIndex:item.tag - kMenuItemBtnStartTag];
            [self renderMenuItem:item andStyle:SHSingleOptionMenuSelectedDefault];
        }
    }
}

#pragma mark - public

- (void)resetMenuItemStatusWithIndex:(NSInteger)index {
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
//        temp.titleLabel.font = kAdaptedFontWithSize(12);
        temp.titleLabel.font = [UIFont systemFontOfSize:12];
        [temp addTarget:self action:@selector(menuItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *border = [self menuItemBorderViewWithItem:temp];
        [self.containerScrollView addSubview:border];
        
        [self.menuBorders addObject:border];
        [self.menus addObject:temp];
    }
}

- (CGFloat)itemSpace {
    if ([self.delegate respondsToSelector:@selector(singleOptionMenuItemSpace)]) {
        return [self.delegate singleOptionMenuItemSpace];
    }
    
    return 0.f;
}

- (CGFloat)itemHeight {
    if ([self.delegate respondsToSelector:@selector(singleOptionMenuitemHeight)]) {
        return [self.delegate singleOptionMenuitemHeight];
    }
    
    return 0.f;
}

- (CGFloat)menuPadding {
    if ([self.delegate respondsToSelector:@selector(singleOptionMenuMargin)]) {
        return [self.delegate singleOptionMenuMargin];
    }
    
    return 0.f;
}

- (SHSingleOptionMenuSelectedStyle)itemSelectedStyleWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(itemSelectedStyleWithIndex:)]) {
        return [self.delegate itemSelectedStyleWithIndex:index];
    }
    
    return SHSingleOptionMenuSelectedDefault;
}

- (void)renderMenuItem:(UIButton *)item andStyle:(SHSingleOptionMenuSelectedStyle)style {
    
    item.layer.borderWidth = 0.f;
    self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
    
    switch (style) {
        case SHSingleOptionMenuSelectedDefault:
            break;
            
        case SHSingleOptionMenuSelectedRedBorder:
        {
            item.layer.borderColor = colorHex(@"DD1712").CGColor;
            item.layer.borderWidth = 1.f;
        }
            break;
            
        case SHSingleOptionMenuSelectedExpand:
        {
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

- (void)setOptionMenuSource:(NSArray<SHSingleOptionMenuEntityModel *> *)optionMenuSource {
    if (![optionMenuSource isKindOfClass:[NSArray class]]) {
        return;
    }
    
    _optionMenuSource = [optionMenuSource copy];
    [self createOptionMenuItems];
}

@end
