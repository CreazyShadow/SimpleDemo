//
//  ChildTableViewCell.m
//  SimpleApp
//
//  Created by wuyp on 2017/10/9.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ChildTableViewCell.h"

@interface ChildTableViewCell()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ChildTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tableview];
        
        MJWeakSelf
        weakSelf.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.tableview.mj_footer endRefreshing];
            if (self.source.count >= 30) {
                return;
            }
            
            for (int i = 0; i < 10; i++) {
                [self.source addObject:[NSString stringWithFormat:@"%@%d", self.section, i]];
            }
            
            [self.tableview reloadData];
            
            !self.reloadSection ?: self.reloadSection(self.sectionNum, self.source.count * 30);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableview.height = self.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.source.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%ld",_section, indexPath.row];
    return cell;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height) style:UITableViewStyleGrouped];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    
    return _tableview;
}

@end
