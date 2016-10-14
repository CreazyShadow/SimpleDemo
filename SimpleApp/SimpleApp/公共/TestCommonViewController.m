//
//  TestCommonViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/7/6.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestCommonViewController.h"

#import <CircleLayer.h>
#import <Masonry.h>

#import <PageView.h>
#import <PageViewItem.h>

@interface TestCommonViewController () <PageViewDelegate, PageViewDataSource>

@property (nonatomic, strong) CAShapeLayer *tempLayer;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *tempView;


@end

@implementation TestCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PageView *view = [[PageView alloc] initWithFrame:CGRectMake(0, 100, 375, 300)];
    view.delegate = self;
    view.dataSource = self;
    
    [self.view addSubview:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:nil];
}

#pragma mark - YZTPageViewDataSource & delegate

- (NSInteger)numberOfPagesInPageView:(PageView *)pageView {
    return 5;
}

- (PageViewItem *)pageView:(PageView *)pageView itemForPageAtIndex:(NSInteger)index {
    PageViewItem *item = [pageView dequeueReusableItemWithIdentifier:@"ITEM"];
    if (!item) {
        item = [[PageViewItem alloc] initWithResuseIndetifier:@"ITEM"];
    }
    
    return item;
}

#pragma mark - Test ViewUtility

@end
