//
//  SHSingleOptionMenuHeaderItemView.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/23.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "SHSingleOptionMenuHeaderItemView.h"

#define kDefaultMenuColor  colorHex(@"333333")
#define kSelectedMenuColor colorHex(@"DD1712")

#pragma mark - entity model

@implementation SHOptionMenuHeaderItemEntityModel

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    SHOptionMenuHeaderItemEntityModel *model = [SHOptionMenuHeaderItemEntityModel allocWithZone:zone];
    model.title = self.title;
    model.icon = self.icon;
    model.selectedIcon = self.selectedIcon;
    model.iconIsLeft = self.iconIsLeft;
    model.group = self.group;
    return model;
}

@end

#pragma mark - item view

@interface SHSingleOptionMenuHeaderItemView ()

@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, assign) SHOptionMenuHeaderItemStyle style;

@end

@implementation SHSingleOptionMenuHeaderItemView

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame style:(SHOptionMenuHeaderItemStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.style = style;
        self.clipsToBounds = YES;
        [self buildSubViews];
        
        self.status = SHMenuHeaderItemStateDefault;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat y = (self.height - _titleHeight) * 0.5;
    _borderView.frame = CGRectMake(0, y, self.width, self.height - y + 5);
    _titleBtn.frame = CGRectMake(0, y, self.width, _titleHeight);
    
    //排列图片和文字
    if (self.model.iconIsLeft) {
        [_titleBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:4];
    } else {
        [_titleBtn setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:4];
    }
}

#pragma mark - init subviews

- (void)buildSubViews {
    CGFloat y = (self.height - 25) * 0.5;
    self.borderView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.width, self.height - y + 2)];
    _borderView.userInteractionEnabled = NO;
    _borderView.layer.borderColor = colorHex(@"F0F0F0").CGColor;
    [self addSubview:_borderView];
    
    self.titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, self.width, 25)];
    _titleBtn.userInteractionEnabled = NO;
    _titleBtn.layer.cornerRadius = 2.0f;
    _titleBtn.layer.borderColor = colorHex(@"F0F0F0").CGColor;
    _titleBtn.titleLabel.numberOfLines = 1;
    _titleBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_titleBtn setTitleColor:kDefaultMenuColor forState:UIControlStateNormal];
    [_titleBtn setTitleColor:kSelectedMenuColor forState:UIControlStateSelected];
    
    [self addSubview:_titleBtn];
}

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

- (void)setStatus:(SHOptionMenuHeaderItemState)status {
    _status = status;
    
    BOOL isPlainStyle = _style == SHOptionMenuHeaderItemStylePlain;
    
    switch (status) {
        case SHMenuHeaderItemStateDefault:
        {
            _borderView.layer.borderWidth = 0;
            _titleBtn.selected = NO;
            _titleBtn.backgroundColor = isPlainStyle ? [UIColor clearColor] : colorHex(@"F7F7F7");
            _titleBtn.layer.borderWidth = 0;
        }
            break;
            
        case SHMenuHeaderItemStateSelecting:
        {
            _borderView.layer.borderWidth = isPlainStyle ? 0 : 1;
            _titleBtn.selected = YES;
            _titleBtn.backgroundColor = [UIColor clearColor];
            _titleBtn.layer.borderWidth = 0;
        }
            break;
            
        case SHMenuHeaderItemStateSelected:
        {
            _borderView.layer.borderWidth = 0;
            _titleBtn.selected = YES;
            _titleBtn.backgroundColor = [UIColor clearColor];
            _titleBtn.layer.borderWidth = isPlainStyle ? 0 : 1;
        }
            break;
    }
}

- (void)setModel:(SHOptionMenuHeaderItemEntityModel *)model {
    _model = model;
    
    [_titleBtn setTitle:model.title forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:model.selectedIcon] forState:UIControlStateSelected];
    
    [self setNeedsLayout];
}

- (void)setTitleHeight:(CGFloat)titleHeight {
    _titleHeight = titleHeight;
    
    [self setNeedsLayout];
}

@end
