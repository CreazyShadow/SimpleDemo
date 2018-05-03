//
//  SHSingleOptionMenuView.h
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHMenuHeaderStyle) {
    SHMenuHeaderStylePlainText, ///< 扁平文字
    SHMenuHeaderStyleCube       ///< 方块形状
};

@interface SHSingleOptionMenuHeaderEntityModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, assign) BOOL iconIsLeft;
@property (nonatomic, copy) NSString *groupName;

@end

@protocol SingleOptionMenuHeaderDelegate <NSObject>

- (NSInteger)numberOfItemsCount;

- (SHSingleOptionMenuHeaderEntityModel *)itemEntityModelForIndex:(NSInteger)index;

@optional
/**
 用于设置item的样式
 */
- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index;

- (void)menuHeaderDidClickItem:(UIButton *)btn index:(NSInteger)index isChangeTab:(BOOL)isChangeTab;

@end

@interface SHSingleOptionMenuHeaderView : UIView

//@property (nonatomic, strong) NSArray<SHSingleOptionMenuHeaderEntityModel *> *optionMenuSource;
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
