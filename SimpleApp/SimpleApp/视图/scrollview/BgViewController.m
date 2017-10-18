//
//  BgViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/10/18.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "BgViewController.h"

@interface BgViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation BgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgImageView.frame = self.table.bounds;
    [self.view  addSubview:self.table];
    [self.table.layer addSublayer:self.bgImageView.layer];
    self.bgImageView.layer.zPosition = -1;
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    header.backgroundColor = [UIColor clearColor];
    self.table.tableHeaderView = header;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"AAAAAAA";
    return cell;
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.layer.borderColor = [UIColor purpleColor].CGColor;
        _table.layer.borderWidth = 2;
        _table.backgroundColor = [UIColor clearColor];
        _table.estimatedSectionFooterHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _table;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"InviteSendGift"]];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _bgImageView;
}

@end
