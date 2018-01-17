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

#import "SubView.h"

#import <Photos/PHImageManager.h>


@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource, HXEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *source;

@end

@implementation SecondViewController
{
    UIView *_maskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SecondViewController";
    
    [self.view addSubview:self.tableView];
    
//    self.tableView.canDisplayEmptyPlaceView = YES;
    self.tableView.emptyDataSource = self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.canDisplayEmptyPlaceView = YES;
//        @try {
//            _tableView.canDisplayEmptyPlaceView = YES;
//        } @catch (NSException *exception) {
//            NSLog(@"%@", exception);
//        } @finally {
//
//        }
        
        [_tableView registerNib:[UINib nibWithNibName:@"ProductSliderTableViewCell" bundle:nil] forCellReuseIdentifier:@"sliderCell"];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __weak typeof(self) weakS = self;
            weakS.source = @[@1, @2];
            [weakS.tableView reloadData];
            [_tableView.mj_header endRefreshing];
        }];
    }
    
    return _tableView;
}

#pragma mark - HXDataSource

- (UIView *)placeHolderViewForDataSet:(UIScrollView *)scrollView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}

#pragma mark - tableivew delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.source.count;
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
//    [self.navigationController popViewControllerAnimated:YES];
    
    if (!_maskView.superview) {
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        maskView.backgroundColor = [UIColor orangeColor];
        maskView.alpha = 0.3;
        maskView.userInteractionEnabled = NO;
//        [self.navigationController.view insertSubview:maskView atIndex:0];
        [self.view.superview insertSubview:maskView atIndex:0];
        _maskView = maskView;
    }
}

@end
