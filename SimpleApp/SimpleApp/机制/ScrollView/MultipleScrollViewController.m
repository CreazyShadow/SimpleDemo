//
//  MultipleScrollViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/11/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "MultipleScrollViewController.h"

#import "UIScrollView+Multiple.h"

@interface MultipleScrollViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIScrollView *subScrollView;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation MultipleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainScrollView];
    
    self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 400)];
    header.backgroundColor = [UIColor purpleColor];
    [self.mainScrollView addSubview:header];
    
    UIView *center = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.width, 400)];
    center.backgroundColor = [UIColor yellowColor];
    [self.mainScrollView addSubview:center];
    
    [self.mainScrollView addSubview:self.subScrollView];
}

#pragma mark - scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setupScrollOffsetState:scrollView maxCondtion:^BOOL{
        return scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.height - 0.5;
    }];
    
    if ([scrollView isEqual:self.mainScrollView]) {
      
        if (self.webView.scrollView.offsetState != ScrollOffsetStateMin || self.subScrollView.offsetState != ScrollOffsetStateMin) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - 600);
        }
        
    } else {
        if (self.mainScrollView.offsetState != ScrollOffsetStateMax) {
            self.webView.scrollView.contentOffset = CGPointZero;
            self.subScrollView.contentOffset = CGPointZero;
        }
    }
}

- (void)setupScrollOffsetState:(UIScrollView *)scroll maxCondtion:(BOOL(^)())condtion {
    if (scroll.isSuperScroll && !condtion) {
        return;
    }
    
    scroll.offsetState = ScrollOffsetStateCenter;
    if (scroll.contentOffset.y <= 0) {
        scroll.offsetState = ScrollOffsetStateMin;
        return;
    }
    
    if (scroll.isSuperScroll && condtion()) {
        scroll.offsetState = ScrollOffsetStateMax;
    }
}

#pragma mark - getter & setter

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainScrollView.delegate = self;
        _mainScrollView.needMultipleScroll = YES;
        _mainScrollView.isSuperScroll = YES;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.contentSize = CGSizeMake(0, 1400);
        _mainScrollView.layer.borderWidth = 2;
        _mainScrollView.layer.borderColor = [UIColor greenColor].CGColor;
    }
    
    return _mainScrollView;
}

- (UIScrollView *)subScrollView {
    if (!_subScrollView) {
        _subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 800, self.view.width, 600)];
        _subScrollView.delegate = self;
        _subScrollView.needMultipleScroll = YES;
        _subScrollView.isSuperScroll = NO;
        _subScrollView.showsVerticalScrollIndicator = NO;
        _subScrollView.contentSize = CGSizeMake(0, 1000);
        _subScrollView.backgroundColor = [UIColor redColor];
        _subScrollView.layer.borderWidth = 1;
        _subScrollView.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    return _subScrollView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 800, self.view.width, 600)];
        _webView.scrollView.delegate = self;
        _webView.scrollView.needMultipleScroll = YES;
        _webView.scrollView.isSuperScroll = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.layer.borderWidth = 1;
        _webView.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    return _webView;
}

@end
