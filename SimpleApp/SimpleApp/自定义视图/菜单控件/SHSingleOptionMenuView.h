//
//  SHSingleOptionMenuView.h
//  ShihuoIPhone
//
//  Created by 邬勇鹏 on 2018/4/23.
//  Copyright © 2018年 hupu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHSingleOptionMenuSelectedStyle) {
    SHSingleOptionMenuSelectedDefault,      ///< 红色文字
    SHSingleOptionMenuSelectedRedBorder,    ///< 红色外框
    SHSingleOptionMenuSelectedExpand        ///< 展开边框
};

@interface SHSingleOptionMenuEntityModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, assign) BOOL iconIsRight;

@end

@protocol SingleOptionMenuDelegate <NSObject>

@optional
- (CGFloat)singleOptionMenuItemSpace;
- (CGFloat)singleOptionMenuitemHeight;
- (CGFloat)singleOptionMenuMargin;

/**
 用于设置item的样式
 */
- (void)willDisplayMenuItem:(UIButton *)btn index:(NSInteger)index;

/**
 item选中时的样式
 */
- (SHSingleOptionMenuSelectedStyle)itemSelectedStyleWithIndex:(NSInteger)index;

- (void)didSelectedMenuItem:(UIButton *)btn index:(NSInteger)index entity:(SHSingleOptionMenuEntityModel *)entity;

@end

@interface SHSingleOptionMenuView : UIView

@property (nonatomic, strong) NSArray<SHSingleOptionMenuEntityModel *> *optionMenuSource;
@property (nonatomic, weak) id<SingleOptionMenuDelegate> delegate;


- (void)resetMenuItemStatusWithIndex:(NSInteger)index;

@end
