//
//  SearchViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/11.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSArray *source;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    //创建UISearchController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater= self;
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    // 添加 searchbar 到 headerview
    self.tableview.tableHeaderView = _searchController.searchBar;
    
    _tableview.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    [self.view addSubview:_tableview];
}



#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.source.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    if (self.searchController.active) {
        cell.textLabel.text = self.source[indexPath.section];
    }
    else{
        cell.textLabel.text = self.source[indexPath.section];
    }
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.source;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.source[section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (NSArray *)source {
    if (!_source) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            [temp addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _source = [temp copy];
    }
    
    return _source;
}


@end
