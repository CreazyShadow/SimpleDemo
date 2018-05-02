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

typedef NS_ENUM(NSInteger, SHMenuHeaderSelectingStyle) {
    SHMenuHeaderSelectingStyleRedText,      ///< 红色文字
    SHMenuHeaderSelectingStyleExpand        ///< 展开边框
};

@implementation SHSingleOptionMenuHeaderEntityModel
@end

@interface SHSingleOptionMenuHeaderView()

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, assign) SHMenuHeaderStyle style;

@property (nonatomic, strong) NSMutableArray<UIView *> *menuBorders;///< 包括item的border source
@property (nonatomic, strong) NSMutableArray<UIButton *> *menus;    ///< item source

@end

@implementation SHSingleOptionMenuHeaderView

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame style:(SHMenuHeaderStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.menus = [NSMutableArray array];
        self.menuBorders = [NSMutableArray array];
        self.style = style;
        
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
//        if ([self.delegate respondsToSelector:@selector(willDisplayMenuHeaderItem:index:)]) {
//            [self.delegate willDisplayMenuHeaderItem:_menus[i] index:i];
//        }
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
    static UIButton *lastItem = nil;
    NSInteger selectedIndex = btn.tag - kMenuItemBtnStartTag;
    
    BOOL isChangeTab = [self itemShouldChangeStatusWithLast:lastItem current:btn];
    if (isChangeTab) {
        lastItem.selected = NO;
        [self renderMenuItem:lastItem andStatus:NO];
    }
    
    lastItem = btn;
    
    [self updateItemStatusToSelecting:btn.tag - kMenuItemBtnStartTag];
    
    if ([self.delegate respondsToSelector:@selector(menuHeaderDidClickItem:index:entity:isChangeTab:)]) {
        [self.delegate menuHeaderDidClickItem:btn index:selectedIndex entity:_optionMenuSource[selectedIndex] isChangeTab:isChangeTab];
    }
}

#pragma mark - public

- (void)reloadItemWithTitle:(NSString *)title index:(NSInteger)index {
    [self.menus[index] setTitle:title forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)reloadItemByEntity:(SHSingleOptionMenuHeaderEntityModel *)entity index:(NSInteger)index {
    if (!entity || !entity.title.length || index < 0 || index >= _optionMenuSource.count) {
        return;
    }
    
    UIButton *item = self.menus[index];
    [item setTitle:entity.title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:entity.icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:entity.selectedIcon] forState:UIControlStateSelected];
    [self setNeedsLayout];
}

- (void)updateMenuItemStatus:(BOOL)status index:(NSInteger)index {
    if (index < 0 || index >= self.menus.count) {
        return;
    }
    
    [self renderMenuItem:self.menus[index] andStatus:status];
}

#pragma mark - private

- (void)createOptionMenuItems {
    [self.menuBorders makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menus removeAllObjects];
    [self.menuBorders removeAllObjects];
    
    for (int i = 0; i < _optionMenuSource.count; i++) {
        UIButton *temp = [[UIButton alloc] init];
        temp.layer.cornerRadius = 2.0f;
        temp.titleLabel.numberOfLines = 1;
        temp.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
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
        
        //render item
        [self renderMenuItem:temp andStatus:NO];
    }
    
    [self setNeedsLayout];
}

- (BOOL)itemShouldChangeStatusWithLast:(UIButton *)last current:(UIButton *)current {
    if (last.tag == current.tag || !last) {
        return NO;
    }
    
    NSString *lastGroup = self.optionMenuSource[last.tag - kMenuItemBtnStartTag].groupName;
    NSString *currentGroup = self.optionMenuSource[current.tag - kMenuItemBtnStartTag].groupName;
    if (![lastGroup isEqualToString:currentGroup]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - change item ui

- (void)updateItemStatusToSelecting:(NSInteger)index {
    SHMenuHeaderSelectingStyle selectingStyle = _style == SHMenuHeaderStylePlainText ? SHMenuHeaderSelectingStyleRedText : SHMenuHeaderSelectingStyleExpand;
    [self renderMenuItem:self.menus[index] andStyle:selectingStyle];
}

- (void)renderMenuItem:(UIButton *)item andStatus:(BOOL)status {
    item.selected = status;
    item.backgroundColor = _style == SHMenuHeaderStylePlainText ? [UIColor clearColor] : colorHex(@"F7F7F7");
    
    item.layer.borderWidth = 0.f;
    self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
    self.menuBorders[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor clearColor];
    if (status && _style == SHMenuHeaderStyleCube) {
        item.backgroundColor = [UIColor clearColor];
        item.layer.borderColor = colorHex(@"DD1712").CGColor;
        item.layer.borderWidth = 1.f;
    }
}

- (void)renderMenuItem:(UIButton *)item andStyle:(SHMenuHeaderSelectingStyle)style {
    
    self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
    switch (style) {
            case SHMenuHeaderSelectingStyleRedText:
        {
            item.selected = YES;
        }
            break;
            
            case SHMenuHeaderSelectingStyleExpand:
        {
            item.selected = YES;
            self.menus[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor clearColor];
            self.menus[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
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
