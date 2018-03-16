//
//  HXListView.m
//  TZYJ_IPhone
//
//  Created by 邵运普 on 2017/12/12.
//

#import "HXListView.h"

#define DefaultRowHeight        44.f
#define SubViewTags             6666
#define DefaultColumnWidth      88.f
#define ContentOffset           @"contentOffset"

@interface HXListView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HXListView

-(void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:ContentOffset];
    [self.tableView removeObserver:self forKeyPath:ContentOffset];
}

#pragma mark - initialize
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = DefaultRowHeight;
        self.columnWidth = DefaultColumnWidth;
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.tableView];
        [self.scrollView addObserver:self forKeyPath:ContentOffset options:NSKeyValueObservingOptionNew context:nil];
        [self.tableView addObserver:self forKeyPath:ContentOffset options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator  = NO;
        _tableView.showsVerticalScrollIndicator    = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
#endif
    }
    return _tableView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.scrollView.contentOffset = CGPointMake(0, -64);
//    self.tableView.contentOffset = CGPointZero;
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGFloat minWidth = [self scrollViewContentSize];
    CGFloat actualWidth = minWidth > self.width ? minWidth : self.width;
    self.scrollView.contentSize = CGSizeMake(actualWidth, self.frame.size.height);
    self.tableView.frame = CGRectMake(0, 0, actualWidth, self.frame.size.height);
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(listView:didSelectedRowAtIndexPath:)]) {
        [self.delegate listView:self didSelectedRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(listView:heightForRowAtIndexPath:)]) {
        return [self.delegate listView:self heightForRowAtIndexPath:indexPath];
    }
    return self.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(listView:heightForHeaderInSection:)]) {
        return [self.delegate listView:self heightForHeaderInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(listView:viewForHeader:inSection:column:)]) {
        static NSString *headerId = @"headerId";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerId];
            headerView.backgroundView = [[UIView alloc] init];
            headerView.backgroundView.backgroundColor = [UIColor clearColor];
            headerView.contentView.backgroundColor = [UIColor clearColor];
        }
        
        NSInteger numberOfColumn = [self.dataSource numberOfColumnsInListView:self] + 1;
        CGFloat x = 0;
        for (int column=0; column<numberOfColumn; column++) {
            UIView *view = [headerView.contentView viewWithTag:SubViewTags+column];
            
            if (!column) {
                view = [self.delegate listView:self viewForStableHeader:view inSection:section];
                view.tag = SubViewTags+column;
                view.frame = CGRectMake(0, 0, [self stableWidth], [self.delegate listView:self heightForHeaderInSection:section]);
                x = [self stableWidth];
            } else {
                view = [self.delegate listView:self viewForHeader:view inSection:section column:(column-1)];
                view.tag = SubViewTags + column;
                view.frame = CGRectMake(x, 0, [self columnWidthInColumn:(column-1)], [self.delegate listView:self heightForHeaderInSection:section]);
                x += [self columnWidthInColumn:(column-1)];
            }
        
            if (!view.superview) {
                [headerView.contentView addSubview:view];
            }
        }
        [headerView.contentView bringSubviewToFront:[headerView.contentView viewWithTag:SubViewTags]];
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInListView:)]) {
        return [self.dataSource numberOfSectionsInListView:self];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource listView:self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellIdentifier";
    HXListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HXListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.contentView.backgroundColor  = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.selectionColor) {
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = self.selectionColor;
            cell.selectedBackgroundView = view;
        }
    }
    cell.indexPath = indexPath;
    NSInteger numberOfColumns = [self.dataSource numberOfColumnsInListView:self] + 1;
    if (numberOfColumns >1) {
        CGFloat x = 0;
        for (int column=0; column<numberOfColumns; column++) {
            UIView *view = [cell.contentView viewWithTag:SubViewTags+column];
            
            if (!column) {
                view = [self.dataSource listView:self stableView:view indexPath:indexPath];
                view.tag = SubViewTags+column;
                view.frame = CGRectMake(0, 0, [self stableWidth], [self rowHeightAtIndexPath:indexPath]);
                x = [self stableWidth];
            } else {
                view = [self.dataSource listView:self columnView:view indexPath:indexPath column:(column-1)];
                view.tag = SubViewTags+column;
                view.frame = CGRectMake(x, 0, [self columnWidthInColumn:(column-1)], [self rowHeightAtIndexPath:indexPath]);
                x+= [self columnWidthInColumn:(column-1)];
            }
            
            if (!view.superview) {
                [cell.contentView addSubview:view];
            }
        }
        [cell.contentView bringSubviewToFront:[cell.contentView viewWithTag:SubViewTags]];
    }
    return cell;
}
#pragma mark - public
- (void)reloadData {
    [self.tableView reloadData];
    [self setNeedsLayout];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tableView reloadSections:sections withRowAnimation:animation];
    [self setNeedsLayout];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self setNeedsLayout];
}

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point {
    return [self.tableView indexPathForRowAtPoint:point];
}

#pragma mark - private
- (CGFloat)stableWidth {
    if ([self.delegate respondsToSelector:@selector(widthForStableInlistView:)]) {
        return [self.delegate widthForStableInlistView:self];
    } else {
        return self.columnWidth;
    }
}

- (CGFloat)columnWidthInColumn:(NSInteger)column {
    if ([self.delegate respondsToSelector:@selector(listView:widthForCulumn:)]) {
        return [self.delegate listView:self widthForCulumn:column];
    } else {
        return self.columnWidth;
    }
}

- (CGFloat)rowHeightAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(listView:heightForRowAtIndexPath:)]) {
        return [self.delegate listView:self heightForRowAtIndexPath:indexPath];
    } else {
        return self.rowHeight;
    }
}

- (CGFloat)scrollViewContentSize {
    CGFloat total = 0.0;
    NSInteger numberOfColumns = [self.dataSource numberOfColumnsInListView:self];
    for (int column=0; column<numberOfColumns; column++) {
        total += [self columnWidthInColumn:column];
    }
    total += [self stableWidth];
    return total;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if([keyPath isEqualToString:ContentOffset]) {
        NSArray *visibleCells = [self.tableView visibleCells];
        NSMutableSet *sectionSet = [[NSMutableSet alloc] init];
        
        for (HXListViewCell *cell in visibleCells) {
            [sectionSet addObject:@(cell.indexPath.section)];
            UIView *fixedView = [cell.contentView viewWithTag:SubViewTags];
            if (fixedView) {
                CGRect frame = fixedView.frame;
                frame.origin.x = self.scrollView.contentOffset.x;
                fixedView.frame = frame;
                
                NSLog(@"-KVO---%f", fixedView.x);
            }
        }
        for (NSNumber *section in sectionSet) {
            UITableViewHeaderFooterView *headerView = [self.tableView headerViewForSection:[section integerValue]];
            UIView *fixedView = [headerView viewWithTag:SubViewTags];
            if (fixedView) {
                CGRect frame = fixedView.frame;
                frame.origin.x = self.scrollView.contentOffset.x;
                fixedView.frame = frame;
            }
        }
//        UIView *refreshHeaderView = [self.tableView valueForKey:@"hx_header"];
//        UIView *refreshFooterView = [self.tableView valueForKey:@"hx_footer"];
//        if (!refreshFooterView) {
//            refreshFooterView = [self.tableView valueForKey:@"footer"];
//        }
//        if (!refreshHeaderView) {
//            refreshHeaderView = [self.tableView valueForKey:@"header"];
//        }
//        if (refreshHeaderView) {
//            CGRect frame = refreshHeaderView.frame;
//            frame.origin.x = self.scrollView.contentOffset.x;
//            frame.size.width = self.frame.size.width;
//            refreshHeaderView.frame = frame;
//        }
//        if (refreshFooterView) {
//            CGRect frame = refreshFooterView.frame;
//            frame.size.width = self.frame.size.width;
//            frame.origin.x = self.scrollView.contentOffset.x;
//            refreshFooterView.frame = frame;
//        }
    }
}

#pragma mark - property
- (UIScrollView *)contentScrollView {
    return self.tableView;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
}

- (void)setColumnWidth:(CGFloat)columnWidth {
    _columnWidth = columnWidth;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.tableView.backgroundColor  =  backgroundColor;
}

- (void)setListHeaderView:(UIView *)listHeaderView {
    self.tableView.tableHeaderView = listHeaderView;
}

@end
