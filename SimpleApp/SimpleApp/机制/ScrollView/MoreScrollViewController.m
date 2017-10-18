//
//  MoreScrollViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/10/9.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "MoreScrollViewController.h"
#import "ChildTableViewCell.h"

@interface MoreScrollViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *rowHeightDict;

@end

@implementation MoreScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.rowHeightDict = [NSMutableDictionary dictionary];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSString *value = self.rowHeightDict[key];
    
    return value.intValue > 300 ? value.intValue : 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.section = @"AAA";
            break;
            
        case 1:
            cell.section = @"BBB";
            break;
            
        case 2:
            cell.section = @"CCC";
            break;
            
        default:
            break;
    }
    
    cell.sectionNum = indexPath.section;
    cell.source = [@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"] mutableCopy];
    MJWeakSelf
    cell.reloadSection = ^(NSInteger section, CGFloat height) {
        NSString *key = [NSString stringWithFormat:@"%ld", section];
        NSString *value = [NSString stringWithFormat:@"%f", height];
        weakSelf.rowHeightDict[key] = value;
//        [weakSelf.tableview reloadData];
        [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
    };
    
    return cell;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableview registerClass:[ChildTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableview.backgroundColor = [UIColor purpleColor];
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    
    return _tableview;
}

@end
