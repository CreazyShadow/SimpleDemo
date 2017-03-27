//
//  ReusingViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/28.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ReusingViewController.h"
#import "ReusingCell.h"

@interface ReusingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ReusingViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [_tableview registerClass:[ReusingCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - event

#pragma mark - network

#pragma mark - tableview delegate&datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReusingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.name = [NSString stringWithFormat:@"AAAAAAAA%ld", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"--------%ld", [GlobalInstance shareInstance].count);
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableview reloadRowsAtIndexPaths:@[index] withRowAnimation:YES];
}


#pragma mark - private

#pragma mark - getter & setter

@end
