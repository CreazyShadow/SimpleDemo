//
//  SHSingleOptionMenuHeaderItemView.h
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/23.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHOptionMenuHeaderItemState) {
    SHMenuHeaderItemStateDefault,
    SHMenuHeaderItemStateSelecting,
    SHMenuHeaderItemStateSelected
};

typedef NS_ENUM(NSInteger, SHOptionMenuHeaderItemStyle) {
    SHOptionMenuHeaderItemStylePlain,
    SHOptionMenuHeaderItemStyleBox
};

@interface SHOptionMenuHeaderItemEntityModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectingIcon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, assign) BOOL iconIsLeft;
@property (nonatomic, copy) NSString *group;

@end

@interface SHSingleOptionMenuHeaderItemView : UIControl

- (instancetype)initWithFrame:(CGRect)frame style:(SHOptionMenuHeaderItemStyle)style;

@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, strong) SHOptionMenuHeaderItemEntityModel *model;

@property (nonatomic, assign) SHOptionMenuHeaderItemState status;
@property (nonatomic, assign) CGFloat titleHeight;

@end
