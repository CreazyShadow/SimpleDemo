//
//  ViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/4/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.tableView];
//    self.tableView.tableFooterView = ({
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
//        view.backgroundColor = [UIColor blueColor];
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 375, 30)];
//        [button setTitle:@"Button" forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor redColor];
//        [view addSubview:button];
//        view;
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testGCD];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

#pragma mark - GCD

- (void)testGCD {
    dispatch_barrier_sync(dispatch_get_main_queue(), ^{
        
    });
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


@end
