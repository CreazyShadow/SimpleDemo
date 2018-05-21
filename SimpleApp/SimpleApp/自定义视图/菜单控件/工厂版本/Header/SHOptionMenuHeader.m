//
//  SHOptionMenuHeader.m
//  SimpleApp
//
//  Created by wuyp on 2018/5/13.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "SHOptionMenuHeader.h"

#define kDefaultMenuColor  colorHex(@"333333")
#define kSelectedMenuColor colorHex(@"DD1712")

static NSInteger const kMenuItemBtnStartTag = 10;
static CGFloat const kItemDefaultHeight = 25;

@implementation SHOptionMenuHeaderEntityModel

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    SHOptionMenuHeaderEntityModel *model = [SHOptionMenuHeaderEntityModel allocWithZone:zone];
    model.title = self.title;
    model.icon = self.icon;
    model.selectedIcon = self.selectedIcon;
    model.iconIsLeft = self.iconIsLeft;
    return model;
}

@end

@interface SHOptionMenuHeader ()

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, assign) SHMenuHeaderStyle style;

@property (nonatomic, strong) NSMutableArray<SHOptionMenuHeaderEntityModel *> *entitySource;
@property (nonatomic, strong) NSMutableArray<UIView *> *menuBorders;///< 包括item的border source
@property (nonatomic, strong) NSMutableArray<UIButton *> *menus;    ///< item source

@end

@implementation SHOptionMenuHeader
{
    UIButton *_lastItem;
    BOOL _isFirstCreate;
}

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame style:(SHMenuHeaderStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.menus = [NSMutableArray array];
        self.menuBorders = [NSMutableArray array];
        self.style = style;
        _isFirstCreate = YES;
        
        [self buildSubViews];
    }
    
    return self;
}

#pragma mark - init subviews

- (void)buildSubViews {
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
    _bottomLineView.backgroundColor = colorHex(@"F0F0F0");
    [self addSubview:_bottomLineView];
    
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    [self addSubview:_containerScrollView];
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = [self.delegate numberOfItemsCount];
    if (count == 0) { return; }
    
    //创建items
    if (_isFirstCreate) {
        [self createOptionMenuItems];
        _isFirstCreate = NO;
    }
    
    //更新布局
    CGFloat width = (self.width - (count - 1) * _itemSpace - 2 * _horPadding) / count;
    width = _itemWidth == 0 ? width : _itemWidth;
    CGFloat height = _itemHeight == 0 ? kItemDefaultHeight : _itemHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(width * count, 0);
    for (int i = 0; i < _menus.count && i < _menuBorders.count; i++) {
        //设置item frame
        _menuBorders[i].frame = CGRectMake(_horPadding + (width + _itemSpace) * i, (self.height - height) * 0.5, width, (self.height + height) * 0.5 + 5); // 5px为了超出父视图self
        _menus[i].frame = CGRectMake(0, 0, width, height);
        
        //调整图片位置
        if ([self.delegate itemEntityModelForIndex:i].iconIsLeft) {
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

#pragma mark - event responder

- (void)menuItemClickAction:(UIButton *)btn {
    NSInteger selectedIndex = btn.tag - kMenuItemBtnStartTag;
    
    BOOL isChangeTab = _lastItem && _lastItem.tag != btn.tag;
    if (isChangeTab && _style == SHMenuHeaderStylePlainText) { //切换tab 并且 paintext style
        [self resetOtherItemStatuForCurrentItem:btn];
    }
    
//    [self updateItemStatusToSelecting:btn.tag - kMenuItemBtnStartTag];
    
    if ([self.delegate respondsToSelector:@selector(menuHeaderDidClickItem:index:)]) {
        [self.delegate menuHeaderDidClickItem:btn index:selectedIndex];
    }
    
    _lastItem = btn;
}

- (void)resetOtherItemStatuForCurrentItem:(UIButton *)current {
    for (UIButton *temp in self.menus) {
        if (temp.tag == current.tag) {
            continue;
        }
        
//        [self renderMenuItem:temp andStatus:NO];
    }
}

#pragma mark - private

- (void)createOptionMenuItems {
    NSInteger count = [self.delegate numberOfItemsCount];
    
    [self.menuBorders makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menus removeAllObjects];
    [self.menuBorders removeAllObjects];
    self.entitySource = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        UIButton *temp = [[UIButton alloc] init];
        temp.tag = kMenuItemBtnStartTag + i;
        [temp addTarget:self action:@selector(menuItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        SHOptionMenuHeaderEntityModel *model = [self entityForItemIndex:i];
        [self setupItem:temp withEntityModel:model];
        
        // 保存entity
        [self.entitySource addObject:model];
        
        // 添加border view
        UIView *border = [self menuItemBorderViewWithItem:temp];
        [self.containerScrollView addSubview:border];
        
        [self.menuBorders addObject:border];
        [self.menus addObject:temp];
        
        //render item
//        [self renderMenuItem:temp andStatus:NO];
    }
    
    [self setNeedsLayout];
}

- (void)setupItem:(UIButton *)btn withEntityModel:(SHOptionMenuHeaderEntityModel *)model {
    if (!btn || !model) {
        return;
    }
    
    btn.layer.cornerRadius = 2.0f;
    btn.titleLabel.numberOfLines = 1;
    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [btn setTitle:model.title forState:UIControlStateNormal];
    [btn setTitleColor:kDefaultMenuColor forState:UIControlStateNormal];
    [btn setTitleColor:kSelectedMenuColor forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:model.selectedIcon] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (SHOptionMenuHeaderEntityModel *)entityForItemIndex:(NSInteger)index {
    SHOptionMenuHeaderEntityModel *model = [self.delegate itemEntityModelForIndex:index];
    if (!model) {
        model = [[SHOptionMenuHeaderEntityModel alloc] init];
    }
    
    return model;
}

#pragma mark - change item ui

//- (void)updateItemStatusToSelecting:(NSInteger)index {
//    SHMenuHeaderSelectingStyle selectingStyle = _style == SHMenuHeaderStylePlainText ? SHMenuHeaderSelectingStyleRedText : SHMenuHeaderSelectingStyleExpand;
//    [self renderMenuItem:self.menus[index] andStyle:selectingStyle];
//}
//
//- (void)renderMenuItem:(UIButton *)item andStatus:(BOOL)status {
//    item.selected = status;
//    item.backgroundColor = _style == SHMenuHeaderStylePlainText ? [UIColor clearColor] : colorHex(@"F7F7F7");
//
//    item.layer.borderWidth = 0.f;
//    self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
//    self.menuBorders[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor clearColor];
//    if (status && _style == SHMenuHeaderStyleCube) {
//        item.backgroundColor = [UIColor clearColor];
//        item.layer.borderColor = colorHex(@"DD1712").CGColor;
//        item.layer.borderWidth = 1.f;
//    }
//}
//
//- (void)renderMenuItem:(UIButton *)item andStyle:(SHMenuHeaderSelectingStyle)style {
//
//    self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
//    switch (style) {
//            case SHMenuHeaderSelectingStyleRedText:
//        {
//            item.selected = YES;
//        }
//            break;
//
//            case SHMenuHeaderSelectingStyleExpand:
//        {
//            item.selected = YES;
//            self.menus[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor clearColor];
//            self.menus[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 0.f;
//            self.menuBorders[item.tag - kMenuItemBtnStartTag].backgroundColor = [UIColor whiteColor];
//            self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderWidth = 1;
//            self.menuBorders[item.tag - kMenuItemBtnStartTag].layer.borderColor = colorHex(@"F0F0F0").CGColor;
//        }
//            break;
//    }
//}

- (UIView *)menuItemBorderViewWithItem:(UIButton *)btn {
    UIView *borderView = [[UIView alloc] init];
    [borderView addSubview:btn];
    return borderView;
}

@end
