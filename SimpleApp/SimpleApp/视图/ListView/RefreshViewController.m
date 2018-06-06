//
//  RefreshViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/10/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "RefreshViewController.h"

#import <CommonCrypto/CommonCrypto.h>

@interface RefreshViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *headerView;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:_tableView];
}


#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"列";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsex = scrollView.contentOffset.y;
    if (offsex < 0) {
        _headerView.height = 100 - offsex;
        _headerView.y -= offsex;
    }
    
    NSLog(@"%f %@", offsex, NSStringFromCGRect(_headerView.frame));
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"InviteSendGift"]];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _headerView;
}


@end
