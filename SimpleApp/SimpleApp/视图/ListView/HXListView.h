//
//  HXListView.h
//  TZYJ_IPhone
//
//  Created by 邵运普 on 2017/12/12.
//  HXListView : 第一列为不可滑动列(stable), 其余列为可滑动列()column, 代理方法分别对应

#import <UIKit/UIKit.h>
#import "HXListViewCell.h"

@protocol HXListViewDelegate;
@protocol HXListViewDataSource;


@interface HXListView : UIView

@property (nonatomic, assign) id <HXListViewDataSource> dataSource;
@property (nonatomic, assign) id <HXListViewDelegate> delegate;
@property (nonatomic, assign) CGFloat columnWidth;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectionColor;
@property (nonatomic, readonly) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *listHeaderView;
@property (nonatomic, strong) UIView *listFooterView;

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;
- (void)reloadData;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation ;
@end
@protocol HXListViewDelegate <NSObject>

@optional
/*选中行*/
- (void)listView:(HXListView *)listView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
/*行高*/
- (CGFloat)listView:(HXListView *)listView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/*不可滑动列宽*/
- (CGFloat)widthForStableInlistView:(HXListView *)listView;
/*可滑动列宽*/
- (CGFloat)listView:(HXListView *)listView widthForCulumn:(NSInteger)column;
/*段头高*/
- (CGFloat)listView:(HXListView *)listView heightForHeaderInSection:(NSInteger)section;
/*可滑动段头内容*/
- (UIView *)listView:(HXListView *)listView viewForHeader:(UIView *)headerView inSection:(NSInteger)section column:(NSInteger)column;
/*不可滑动段头内容*/
- (UIView *)listView:(HXListView *)listView viewForStableHeader:(UIView *)stableHeaderView inSection:(NSInteger)section;

@end

@protocol HXListViewDataSource <NSObject>

@required
/*行数*/
- (NSInteger)listView:(HXListView *)listView numberOfRowsInSection:(NSInteger)section;
/*可滑动列数*/
- (NSInteger)numberOfColumnsInListView:(HXListView *)listView;
/*可滑动列内容*/
- (UIView *)listView:(HXListView *)listView columnView:(UIView *)columnView indexPath:(NSIndexPath *)indexPath column:(NSInteger)column;
/*不可滑动列内容*/
- (UIView *)listView:(HXListView *)listView stableView:(UIView *)stableView indexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfSectionsInListView:(HXListView *)listView;

@end
