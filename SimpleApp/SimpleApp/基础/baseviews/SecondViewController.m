//
//  SecondViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/6/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFRunLoop.h>
#import "ProductSliderTableViewCell.h"

#import <Photos/PHImageManager.h>


@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) void(^cycleBlock)(void);

@property (nonatomic, copy) NSString *cycleName;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SecondViewController";
    
    [self.view addSubview:self.tableView];
    
    self.cycleBlock = ^ {
        _cycleName = @"cycle";
    };
}

- (void)dealloc {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"ProductSliderTableViewCell" bundle:nil] forCellReuseIdentifier:@"sliderCell"];
    }
    
    return _tableView;
}

#pragma mark - tableivew delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ProductSliderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sliderCell" forIndexPath:indexPath];
        NSMutableArray *source = [NSMutableArray array];
        cell.backgroundColor = [UIColor orangeColor];
        for (int i = 0; i < 6; i++) {
            [source addObject:[NSString stringWithFormat:@"%d", i]];
        }
        cell.source = source;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"AAAFDFDAFDAFDFDFDA";
    cell.backgroundColor = [UIColor blueColor];
    cell.layer.cornerRadius = 10;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 80 : 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
