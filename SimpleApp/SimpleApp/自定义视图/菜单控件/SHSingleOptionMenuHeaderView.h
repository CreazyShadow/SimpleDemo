//
//  SHSingleOptionMenuView.h
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHSingleOptionMenuHeaderView;

typedef NS_ENUM(NSInteger, SHMenuHeaderStyle) {
    SHMenuHeaderStylePlainText, ///< 扁平文字
    SHMenuHeaderStyleCube       ///< 方块形状
};

@interface SHSingleOptionMenuHeaderEntityModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, assign) BOOL iconIsLeft;

@end

@protocol SingleOptionMenuHeaderDelegate <NSObject>

- (NSInteger)numberOfItemsCountInHeader:(SHSingleOptionMenuHeaderView *)header;

- (SHSingleOptionMenuHeaderEntityModel *)itemEntityModelForIndex:(NSInteger)index inHeader:(SHSingleOptionMenuHeaderView *)header;

@optional
/**
 用于设置item的样式
 */
- (void)willDisplayMenuHeader:(SHSingleOptionMenuHeaderView *)header item:(UIButton *)btn index:(NSInteger)index;

- (void)menuHeader:(SHSingleOptionMenuHeaderView *)header didClickItem:(UIButton *)btn index:(NSInteger)index isChangeTab:(BOOL)isChangeTab;

@end

@interface SHSingleOptionMenuHeaderView : UIView

@property (nonatomic, weak) id<SingleOptionMenuHeaderDelegate> delegate;

@property (nonatomic, assign) CGFloat itemWidth;    ///< 默认等分
@property (nonatomic, assign) CGFloat itemSpace;    ///< item 间隔
@property (nonatomic, assign) CGFloat itemHeight;   ///< item 高度 默认25
@property (nonatomic, assign) CGFloat horPadding;   ///< 水平间隔 内边距

- (instancetype)initWithFrame:(CGRect)frame style:(SHMenuHeaderStyle)style;

- (void)updateMenuItemStatus:(BOOL)status index:(NSInteger)index;

- (void)reloadItems;
- (void)reloadItemsWithIndexs:(NSSet<NSNumber *> *)indexs;

@end
