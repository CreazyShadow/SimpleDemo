//
//  SHSingleOptionMenuView.h
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/25.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHSingleOptionMenuHeaderView.h"
#import "SHSingleOptionMenuContentView.h"

@class SHSingleOptionMenuView;

@protocol SingleOptionMenuDelegate<NSObject>

@optional
#pragma mark - header setting
/**
 用于设置item的样式
 */
- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index;

/**
 header item选中时的样式
 */
- (SHSingleOptionMenuHeaderSelectedStyle)menuHeaderItemSelectedStyleWithIndex:(NSInteger)index;

#pragma mark - content setting

/**
 item大小
 */
- (CGSize)itemSizeForMenu:(SHSingleOptionMenuView *)menu index:(NSInteger)index;

/**
 设置内容view
 */
- (UIView *)menuContentView:(SHSingleOptionMenuView *)contentView itemForIndex:(NSInteger)index reusableItem:(UIView *)item itemSup:(UIView *)sup;


@end

#pragma mark - entity model

@interface SHSingleOptionMenuEntity : NSObject

@property (nonatomic, strong) SHSingleOptionMenuHeaderEntityModel *headerEntity;
@property (nonatomic, strong) NSArray<NSString *> *content;

@end

#pragma mark - option menu

@interface SHSingleOptionMenuView : UIView

@property (nonatomic, weak) id<SingleOptionMenuDelegate> delegate;

@property (nonatomic, strong) NSArray<SHSingleOptionMenuEntity *> *menuSource;

@property (nonatomic, assign) CGFloat expandHeight;       ///< 展开菜单项时的高度 必须设置

#pragma mark - header
@property (nonatomic, assign) CGFloat headerItemWidth;    ///< 默认等分
@property (nonatomic, assign) CGFloat headerItemSpace;    ///< item 间隔
@property (nonatomic, assign) CGFloat headerItemHeight;   ///< item 高度 默认25
@property (nonatomic, assign) CGFloat headerHorPadding;   ///< 水平间隔 内边距

#pragma mark - content

#pragma mark - method

- (void)reloadMenu;

@end
