//
//  ChildTableViewCell.m
//  SimpleApp
//
//  Created by wuyp on 16/9/15.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ChildTableViewCell.h"

@interface ChildTableViewCell()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation ChildTableViewCell

- (void)awakeFromNib {
    self.tableview.layer.cornerRadius = 10;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
    _headerView.backgroundColor = [UIColor orangeColor];
    self.tableview.tableHeaderView = _headerView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
        cell.textLabel.text = @"AAAA";
    }
    
    return cell;
}

@end
