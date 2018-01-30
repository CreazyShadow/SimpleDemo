//
//  HXListViewViewController.m
//  SimpleApp
//
//  Created by wuyp on 2018/1/25.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "HXListViewViewController.h"

#import "HXListView.h"
#import "CustomLabel.h"

@interface HXListViewViewController ()<HXListViewDataSource, HXListViewDelegate>

@property (nonatomic, strong) HXListView *listView;

@property (nonatomic, assign) NSInteger columnCount;

@end

@implementation HXListViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _columnCount = 3;
    [self.view addSubview:self.listView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
}

- (void)editAction {
    _columnCount = 3;
    [self.listView reloadData];
}

#pragma mark - delegate & datasource

- (NSInteger)listView:(HXListView *)listView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

/*可滑动列数*/
- (NSInteger)numberOfColumnsInListView:(HXListView *)listView {
    return _columnCount;
}

/*可滑动列内容*/
- (UIView *)listView:(HXListView *)listView columnView:(UIView *)columnView indexPath:(NSIndexPath *)indexPath column:(NSInteger)column {
    UILabel *label = [[UILabel alloc] init];
    if (columnView) {
        label = columnView;
    }
    
    label.backgroundColor = [UIColor purpleColor];
    label.text = [NSString stringWithFormat:@"row:%ld, col:%ld", indexPath.row, column];
    return label;
}

/*不可滑动列内容*/
- (UIView *)listView:(HXListView *)listView stableView:(UIView *)stableView indexPath:(NSIndexPath *)indexPath {
    CustomLabel *label = [[CustomLabel alloc] init];
    if (stableView) {
        label = stableView;
    }
    label.backgroundColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"stable row:%ld", indexPath.row];
    return label;
}

#pragma mark -

/*选中行*/
- (void)listView:(HXListView *)listView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
/*行高*/
- (CGFloat)listView:(HXListView *)listView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

/*不可滑动列宽*/
- (CGFloat)widthForStableInlistView:(HXListView *)listView {
    return 120;
}

/*可滑动列宽*/
- (CGFloat)listView:(HXListView *)listView widthForCulumn:(NSInteger)column {
//    if (column < 3) {
//        return 50;
//    }
//
    return 150;
}

/*段头高*/
- (CGFloat)listView:(HXListView *)listView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
/*可滑动段头内容*/
- (UIView *)listView:(HXListView *)listView viewForHeader:(UIView *)headerView inSection:(NSInteger)section column:(NSInteger)column {
    UILabel *label = [[UILabel alloc] init];
    if (headerView) {
        label = headerView;
    }
    label.text = @"可滑动头内容";
    return label;
}

/*不可滑动段头内容*/
- (UIView *)listView:(HXListView *)listView viewForStableHeader:(UIView *)stableHeaderView inSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    if (stableHeaderView) {
        label = stableHeaderView;
    }
    label.text = @"不可滑动头内容";
    return label;
}

#pragma mark - getter & setter

- (HXListView *)listView {
    if (!_listView) {
        _listView = [[HXListView alloc] initWithFrame:self.view.bounds];
        _listView.delegate = self;
        _listView.dataSource = self;
//        _listView.backgroundColor = [UIColor purpleColor];
    }
    
    return _listView;
}


@end
