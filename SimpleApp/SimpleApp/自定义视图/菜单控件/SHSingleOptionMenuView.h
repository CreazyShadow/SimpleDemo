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

#pragma mark - position indexpath

@interface SHOptionMenuIndexPath : NSObject

@property (nonatomic, assign) NSInteger headerIndex;
@property (nonatomic, assign) NSInteger contentIndex;

+ (instancetype)indexPathForHeaderIndex:(NSInteger)hIndex contentIndex:(NSInteger)cIndex;

@end

@protocol SingleOptionMenuDelegate<NSObject>

- (NSInteger)menu:(SHSingleOptionMenuView *)menu numberOfContentItemsCountForHeaderIndex:(NSInteger)index;

- (CGSize)menu:(SHSingleOptionMenuView *)menu itemSizeForIndexPath:(SHOptionMenuIndexPath *)indexPath;

- (UIView *)menu:(SHSingleOptionMenuView *)menu itemForIndexPath:(SHOptionMenuIndexPath *)indexPath reusableItem:(UIView *)item itemSup:(UIView *)sup;

@optional
#pragma mark - header setting
/**
 用于设置item的样式
 */
- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index;

#pragma mark - content setting

- (BOOL)menu:(SHSingleOptionMenuView *)menu canMulSelectedForHeaderIndex:(NSInteger)index;

/**
 是否能够多选
 */
- (BOOL)menu:(SHSingleOptionMenuView *)menu canMultiChoiceForHeaderIndex:(NSInteger)index;

#pragma mark - click action

- (void)menu:(SHSingleOptionMenuView *)menu didSelectedHeaderItem:(NSInteger)index;

- (void)menu:(SHSingleOptionMenuView *)menu didSelectedContentItemForIndexPath:(SHOptionMenuIndexPath *)indexPath;

- (void)menu:(SHSingleOptionMenuView *)menu didClickBottomAction:(BOOL)isConfirm index:(NSInteger)headerIndex;

@end

#pragma mark - option menu

@interface SHSingleOptionMenuView : UIView

@property (nonatomic, weak) id<SingleOptionMenuDelegate> delegate;
@property (nonatomic, strong) NSArray<SHSingleOptionMenuHeaderEntityModel *> *menuHeaderSource;
@property (nonatomic, assign) CGFloat expandHeight;       ///< 展开菜单项时的高度 必须设置

#pragma mark - header
@property (nonatomic, assign) CGFloat headerItemWidth;    ///< 默认等分
@property (nonatomic, assign) CGFloat headerItemSpace;    ///< item 间隔
@property (nonatomic, assign) CGFloat headerItemHeight;   ///< item 高度 默认25
@property (nonatomic, assign) CGFloat headerHorPadding;   ///< 水平间隔 内边距

#pragma mark - content

- (NSArray<SHOptionMenuIndexPath *> *)menuSelectedItemsWithHeaderIndex:(NSInteger)index;

#pragma mark - method

- (void)setupDefaultSelectedIndexPath:(NSArray<SHSingleOptionMenuHeaderEntityModel *> *)indexPaths;

- (void)reloadMenu;
- (void)reloadHeaderItemWithTitle:(NSString *)title index:(NSInteger)index;
- (void)reloadHeaderItemWithEntity:(SHSingleOptionMenuHeaderEntityModel *)entity index:(NSInteger)index;
- (void)reloadContentItemsAtIndexs:(NSSet<NSNumber *> *)indexs;

@end
