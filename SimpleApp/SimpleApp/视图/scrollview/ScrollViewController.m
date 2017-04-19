//
//  ScrollViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/16.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ScrollViewController.h"

#import "RecycleScrollView.h"
#import "TextItem.h"

@interface ScrollViewController () <RecycleScrollViewDataSource>

@property (nonatomic, strong) RecycleScrollView *scrollview;

@end

@implementation ScrollViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollview = [[RecycleScrollView alloc] initWithFrame:CGRectMake(0, 250, kScreenWidth, 200)];
    _scrollview.backgroundColor = [UIColor purpleColor];
    _scrollview.dataSource = self;
//    [_scrollview registClass:[TextItem class] forItemIdentify:@"textitem"];
    [self.view addSubview:_scrollview];
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    _scrollview.layer.transform = CATransform3DMakeRotation(M_PI_2 * 2, 0, 1, 0);
}

#pragma RecycleScrollViewDataSource

- (NSInteger)numberOfPagesInRecyleScrollView {
    return 5;
}

//- (RecyleScrollViewItem *)recycleScrollView:(RecycleScrollView *)scrollview itemForPage:(NSInteger)page {
//    TextItem *item = (TextItem *)[scrollview dequeueReusableItemWithIdentifier:@"textitem"];
//    item.layer.borderColor = [UIColor orangeColor].CGColor;
//    item.layer.borderWidth = 1;
//    [item render:page];
//    return item;
//}

@end
