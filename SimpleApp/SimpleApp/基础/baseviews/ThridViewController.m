//
//  ThridViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/11/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ThridViewController.h"

@interface ThridViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation ThridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.table];
}

#pragma mark - delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            
        case 1:
            return 0;
            
        default:
            return 5;
    }
}



#pragma mark - getter & setter

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        
        _table.estimatedSectionHeaderHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
    }
    
    return _table;
}

@end
