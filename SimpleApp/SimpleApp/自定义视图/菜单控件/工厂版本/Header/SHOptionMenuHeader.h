//
//  SHOptionMenuHeader.h
//  SimpleApp
//
//  Created by wuyp on 2018/5/13.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHMenuHeaderStyle) {
    SHMenuHeaderStylePlainText, ///< 扁平文字
    SHMenuHeaderStyleCube       ///< 方块形状
};

@interface SHOptionMenuHeaderEntityModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, assign) BOOL iconIsLeft;

@end

@protocol OptionMenuHeaderDelegate <NSObject>

- (NSInteger)numberOfItemsCount;

- (SHOptionMenuHeaderEntityModel *)itemEntityModelForIndex:(NSInteger)index;

@optional
/**
 用于设置item的样式
 */
- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index;

- (void)menuHeaderDidClickItem:(UIButton *)btn index:(NSInteger)index;

@end


@interface SHOptionMenuHeader : UIView

@property (nonatomic, weak) id<OptionMenuHeaderDelegate> delegate;

@property (nonatomic, assign) CGFloat itemWidth;    ///< 默认等分
@property (nonatomic, assign) CGFloat itemSpace;    ///< item 间隔
@property (nonatomic, assign) CGFloat itemHeight;   ///< item 高度 默认25
@property (nonatomic, assign) CGFloat horPadding;   ///< 水平间隔 内边距

- (instancetype)initWithFrame:(CGRect)frame style:(SHMenuHeaderStyle)style;

@end
