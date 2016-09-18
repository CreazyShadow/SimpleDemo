//
//  RenderViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/7/5.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "RenderViewController.h"
#import <CircleLayer.h>

@interface RenderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RenderViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    self.navigationController.hidesBarsOnSwipe = true;
    
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - event responder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testLayerContents];
    
}

#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"hidden"] && [object isEqual:self.navigationController.navigationBar]) {
        BOOL new = change[@"new"];
        if (new) {
//            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 20)];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
        }
    }
}

#pragma mark - TableView delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"the row number is:%lu", indexPath.row];
//    cell.layer.shouldRasterize = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL d = self.navigationController.navigationBar.hidden;
}

#pragma mark - layer render

- (void)testLayerContents {
    
}


#pragma mark - getter & setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor grayColor];
    }
    
    return _tableView;
}


@end
