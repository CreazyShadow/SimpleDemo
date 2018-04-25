//
//  SHSingleOptionMenuView.h
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHSingleOptionMenuHeaderSelectedStyle) {
    SHSingleOptionMenuHeaderSelectedDefault,      ///< 红色文字
    SHSingleOptionMenuHeaderSelectedRedBorder,    ///< 红色外框
    SHSingleOptionMenuHeaderSelectedExpand        ///< 展开边框
};

@interface SHSingleOptionMenuHeaderEntityModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, assign) BOOL iconIsLeft;

@end

@protocol SingleOptionMenuHeaderDelegate <NSObject>

@optional
/**
 用于设置item的样式
 */
- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index;

/**
 item选中时的样式
 */
- (SHSingleOptionMenuHeaderSelectedStyle)menuHeaderItemSelectedStyleWithIndex:(NSInteger)index;

- (void)menuHeaderDidClickItem:(UIButton *)btn index:(NSInteger)index entity:(SHSingleOptionMenuHeaderEntityModel *)entity isCancel:(BOOL)cancel;

@end

@interface SHSingleOptionMenuHeaderView : UIView

@property (nonatomic, strong) NSArray<SHSingleOptionMenuHeaderEntityModel *> *optionMenuSource;
@property (nonatomic, weak) id<SingleOptionMenuHeaderDelegate> delegate;

@property (nonatomic, assign) CGFloat itemWidth;    ///< 默认等分
@property (nonatomic, assign) CGFloat itemSpace;    ///< item 间隔
@property (nonatomic, assign) CGFloat itemHeight;   ///< item 高度 默认25
@property (nonatomic, assign) CGFloat horPadding;   ///< 水平间隔 内边距

- (void)resetMenuHeaderItemStatusWithIndex:(NSInteger)index;

@end
