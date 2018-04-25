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
#import "SHSingleOptionMenuHeaderView.h"
#import "SHSingleOptionMenuView.h"

@interface TestCustomViewController ()<SingleOptionMenuDelegate>

@property (nonatomic, strong) SHSingleOptionMenuHeaderView *optionMenu;
@property (nonatomic, strong) SHSingleOptionMenuView *menu;

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
    self.menu = [[SHSingleOptionMenuView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 45)];
    _menu.delegate = self;
    _menu.headerItemSpace = 10;
    _menu.headerItemHeight = 25;
    [self.view addSubview:_menu];
    
    NSMutableArray *entity = [NSMutableArray array];
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    for (NSString *title in titles) {
        SHSingleOptionMenuEntity *temp = [[SHSingleOptionMenuEntity alloc] init];
        
        SHSingleOptionMenuHeaderEntityModel *header = [[SHSingleOptionMenuHeaderEntityModel alloc] init];
        header.title = title;
        header.icon = @"filter_img";
        header.selectedIcon = @"selectd_filter_img";
        header.iconIsLeft = ![titles.lastObject isEqualToString:title];
        
        temp.headerEntity = header;
        
        NSMutableArray *content = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            [content addObject:[NSString stringWithFormat:@"%@----%d", title, i]];
        }
        temp.content = [content copy];
        
        [entity addObject:temp];
    }
    
    _menu.menuSource = entity;
}

#pragma mark - option menu header delegate

- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index {
    if (index ==0 ) {
        
    }
    else if (index == 3) {
        btn.backgroundColor = [UIColor hexStringToColor:@"F7F7F7"];
        return;
    }
}

- (SHSingleOptionMenuHeaderSelectedStyle)menuHeaderItemSelectedStyleWithIndex:(NSInteger)index {
    if (index == 3) {
        return SHSingleOptionMenuHeaderSelectedRedBorder;
    }
    
    if (index == 2 || index == 1) {
        return SHSingleOptionMenuHeaderSelectedExpand;
    }
    
    return SHSingleOptionMenuHeaderSelectedDefault;
}

- (CGSize)itemSizeForMenu:(SHSingleOptionMenuView *)menu index:(NSInteger)index {
    return CGSizeMake(kScreenWidth, 40);
}

- (UIView *)menuContentView:(SHSingleOptionMenuContentView *)contentView itemForIndex:(NSInteger)index reusableItem:(UIView *)item itemSup:(UIView *)sup {
    return nil;
}

@end
