//
//  DrawViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/10/24.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "DrawViewController.h"
#import "DelayDrawView.h"

@interface DrawViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DelayDrawView *delayView;

@property (nonatomic, copy) void(^cycleRefrenceBlock)(NSString *str);

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupScrollView];
    
    _cycleRefrenceBlock = ^(NSString *str){
        [self delayDrawPath:[UIColor redColor]];
    };
}

- (void)dealloc {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.cycleRefrenceBlock(@"test");
}

#pragma mark - ScrollView

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 1000);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

#pragma mark - scrollview delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"-------------");
}

#pragma mark - delay draw path

- (void)delayDrawPath:(UIColor *)color {
    DelayDrawView *view = [[DelayDrawView alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
    view.backgroundColor = color;
    [self.view addSubview:view];
    self.delayView = view;
}

@end
