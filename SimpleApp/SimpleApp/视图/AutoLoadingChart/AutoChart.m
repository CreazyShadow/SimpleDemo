//
//  AutoChart.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "AutoChart.h"
#import "AutoChartPageView.h"

#import <math.h>

static CGFloat const kLeftRightMargin __attribute__((unused)) = 15; ///< 左右边距
static CGFloat const kCriticalPercent = 0.7; ///< 复用偏移量
static NSInteger const kMaxPageViewCount = 3;

@interface AutoChart() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) NSMutableArray<AutoChartPageView *> *pageViewSource;

@end

@implementation AutoChart
{
    NSInteger _currentPage;
    NSInteger _pageCount;
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        
        [self initializeSetting];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _pageCount = [self currentPageCount];
    if (_pageCount <= 0) {
        return;
    }
    
    [self loadPage];
    
    
}

#pragma mark - init sub views

- (void)setupSubviews {
    [self setupContainerView];
}

- (void)setupContainerView {
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _containerScrollView.backgroundColor = [UIColor purpleColor];
    _containerScrollView.contentSize = CGSizeMake(self.width * 3, 0);
    [self addSubview:_containerScrollView];
}

#pragma mark - event

#pragma mark - public

- (void)reloadData {
    
}

#pragma mark - private

- (void)initializeSetting {
    self.pageViewSource = [[NSMutableArray alloc] init];
}

- (void)contactPageView {
    //1.判断是否需要连接
    //2.连接
}

- (void)loadPage {
    if (_pageCount >= kMaxPageViewCount) {
        for (int i = 0; i < kMaxPageViewCount; i++) {
            AutoChartPageView *item = [[AutoChartPageView alloc] initWithYScaleCount:5];
            item.pageModel = [self pageViewSource:i];
            [self.pageViewSource addObject:item];
            [self.containerScrollView addSubview:item];
        }
    }
}

#pragma mark - datasource

- (NSInteger)currentPageCount {
    if ([self.dataSource respondsToSelector:@selector(numberOfPagesInAutoChart)]) {
        return [self.dataSource numberOfPagesInAutoChart];
    }
    
    return 0;
}

- (AutoChartPageModel *)pageViewSource:(NSInteger)page {
    AutoChartPageModel *model = [[AutoChartPageModel alloc] init];
    if ([self.dataSource respondsToSelector:@selector(autoChart:titlesForColumnInPage:)]) {
        model.xSource = [[self.dataSource autoChart:self titlesForColumnInPage:page] copy];
    }
    
    if ([self.dataSource respondsToSelector:@selector(autoChart:rowVauleForColumn:page:)]) {
        NSMutableArray *temp = [NSMutableArray array];
        BOOL isGroup = NO;
        for (int i = 0; i < model.xSource.count; i++) {
            id value = [self.dataSource autoChart:self rowVauleForColumn:i page:page];
            if ([value isKindOfClass:[NSArray class]]) {
                isGroup = YES;
            }
            
            [temp addObject:value];
        }
        
        if (isGroup) {
            model.yGroupSource = temp;
        } else {
            model.ySource = [temp copy];
        }
    }
    
    return model;
}

#pragma mark - 重用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x / self.width;
    NSInteger current = floor(offset);

    switch (current) {
        case kMaxPageViewCount - 2: //第二个视图
        {
            _currentPage += 1;
        }
            break;
            
        case kMaxPageViewCount - 1: //最后一个视图
        {
            _currentPage += 1;
        }
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offset = scrollView.contentOffset.x / self.width;
    NSInteger current = floor(offset);
    static CGFloat old = 0; //上一次位置
}

- (void)scroll:(BOOL)isBefore {
    for (UIView *item in self.containerScrollView.subviews) {
        if (![item isKindOfClass:[AutoChartPageView class]]) {
            continue;
        }
        
        if (isBefore) {
            item.x += self.width;
            if (item.maxX > (kMaxPageViewCount - 1) * self.width + self.width * 0.2) {
                item.x = 0;
            }
        } else {
            item.x -= self.width;
            if (item.maxX - self.width * 0.2 < 0) {
                item.x = (kMaxPageViewCount - 1) * self.width;
            }
        }
    }
}

#pragma mark - getter & setter

@end
