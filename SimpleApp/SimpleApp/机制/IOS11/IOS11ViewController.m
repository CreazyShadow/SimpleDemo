//
//  IOS11ViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/10/14.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "IOS11ViewController.h"
#import "AutoLayoutCell.h"

@interface IOS11ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation IOS11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大大大滴滴答答";
    
    [self.view addSubview:self.tableview];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupTitle:[NSString stringWithFormat:@"标题%ld", indexPath.row] detail:@"详细内容。。。。。"];
    return cell;
}

#pragma mark - getter & setter

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        [_tableview registerClass:[AutoLayoutCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _tableview;
}

@end
