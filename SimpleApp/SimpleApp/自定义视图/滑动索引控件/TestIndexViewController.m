//
//  TestIndexViewController.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/10.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "TestIndexViewController.h"

#import "SHIndexMenuView.h"

@interface TestIndexViewController ()

@property (nonatomic, strong) SHIndexMenuView *indexView;

@end

@implementation TestIndexViewController

#pragma mark - life cycle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indexView = [[SHIndexMenuView alloc] initWithFrame:CGRectMake(200, 80, 30, 500)];
    _indexView.itemH = 13;
    _indexView.itemFont = [UIFont systemFontOfSize:13];
    _indexView.itemColor = [UIColor redColor];
    _indexView.backgroundColor = [UIColor orangeColor];
    NSMutableArray<NSString *> *titles = [[NSMutableArray alloc] init];
    [titles addObject:@"热门"];
    for (char i = 'A'; i <= 'Z'; i++) {
        [titles addObject:[NSString stringWithFormat:@"%c", i]];
    }
    [titles addObject:@"#"];
    _indexView.indexTitlesArray = [titles copy];
    
    [self.view addSubview:_indexView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark - subviews

#pragma mark - event responder

#pragma mark - network

#pragma mark - tableview delegate & datasource

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

@end
