//
//  TestCustomViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestCustomViewController.h"

#import "SelectImageItemView.h"
#import "SelectImageView.h"
#import "SHSingleOptionMenuView.h"

@interface TestCustomViewController ()<SingleOptionMenuDelegate>

@property (nonatomic, strong) SHSingleOptionMenuView *optionMenu;

@property (nonatomic, strong) UIView *expandView;

@end

@implementation TestCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addOptionMenuView];
    [self.view addSubview:self.expandView];
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

#pragma mark - select image view
- (void)addSelectImageView {
    SelectImageItemView *item = [SelectImageItemView loadFromNib];
    item.frame = CGRectMake(0, 80, 100, 100);
    item.backgroundImage = [UIImage imageNamed:@"circle"];
    [self.view addSubview:item];
}

#pragma mark - single option menu view

- (void)addOptionMenuView {
    self.optionMenu = [[SHSingleOptionMenuView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 40)];
    _optionMenu.delegate = self;
   
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSString *title in titles) {
        SHSingleOptionMenuEntityModel *temp = [[SHSingleOptionMenuEntityModel alloc] init];
        temp.title = title;
        temp.icon = @"filter_img";
        temp.selectedIcon = @"selectd_filter_img";
        temp.iconIsRight = ![titles.lastObject isEqualToString:title];
        
        [models addObject:temp];
    }
    
    _optionMenu.optionMenuSource = models;
    
    [self.view addSubview:self.optionMenu];
}

- (CGFloat)singleOptionMenuMargin {
    return 15.f;
}

- (CGFloat)singleOptionMenuItemSpace {
    return 10;
}

- (CGFloat)singleOptionMenuitemHeight {
    return 25;
}

- (void)willDisplayMenuItem:(UIButton *)btn index:(NSInteger)index {
    if (index == 3) {
        btn.backgroundColor = [UIColor hexStringToColor:@"F7F7F7"];
        return;
    }
}

- (SHSingleOptionMenuSelectedStyle)itemSelectedStyleWithIndex:(NSInteger)index {
    if (index == 3) {
        return SHSingleOptionMenuSelectedRedBorder;
    }
    
    if (index == 2 || index == 1) {
        return SHSingleOptionMenuSelectedExpand;
    }
    
    return SHSingleOptionMenuSelectedDefault;
}

- (void)didSelectedMenuItem:(UIButton *)btn index:(NSInteger)index entity:(SHSingleOptionMenuEntityModel *)entity {
    NSLog(@"%@ %ld %@", btn, index, entity.title);
}

#pragma mark - test

- (void)headerAction {
    self.expandView.height = 400;
    [self.expandView viewWithTag:10].hidden = NO;
}

- (void)contentAction {
    NSLog(@"------content click");
}

- (UIView *)expandView {
    if (!_expandView) {
        _expandView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 40)];
        UIButton *header = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        [header setTitle:@"触发" forState:UIControlStateNormal];
        header.backgroundColor = [UIColor orangeColor];
        [header addTarget:self action:@selector(headerAction) forControlEvents:UIControlEventTouchUpInside];
        [_expandView addSubview:header];
        
        UIButton *content = [[UIButton alloc] initWithFrame:CGRectMake(0, header.maxY, kScreenWidth, 300)];
        content.hidden = YES;
        content.tag = 10;
        content.backgroundColor = [UIColor yellowColor];
        [content setTitle:@"DDDDDD" forState:UIControlStateNormal];
        [content addTarget:self action:@selector(contentAction) forControlEvents:UIControlEventTouchUpInside];
        [_expandView addSubview:content];
    }
    
    return _expandView;


@end
