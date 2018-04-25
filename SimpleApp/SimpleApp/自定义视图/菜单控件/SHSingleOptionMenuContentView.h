//
//  SHSingleOptionMenuContentView.h
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/24.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHSingleOptionMenuContentView;

@protocol SingleOptionMenuContentViewDelegate <NSObject>

@optional
- (NSInteger)itemCountForMenuContentView:(SHSingleOptionMenuContentView *)contentView;
- (CGSize)itemSizeForMenuContentView:(SHSingleOptionMenuContentView *)contentView index:(NSInteger)index;

- (UIView *)menuContentView:(SHSingleOptionMenuContentView *)contentView itemForIndex:(NSInteger)index reusableItem:(UIView *)item itemSup:(UIView *)sup;

- (void)menuContentView:(SHSingleOptionMenuContentView *)contentView didSelectItem:(NSInteger)index;

@end

@interface SHSingleOptionMenuContentView : UIView

@property (nonatomic, weak) id<SingleOptionMenuContentViewDelegate> delegate;
@property (nonatomic, assign, readonly) CGFloat expectHeight;

- (void)reloadData;

@end
