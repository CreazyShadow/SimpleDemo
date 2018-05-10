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
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.menu resetMenu];
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
    self.menu = [[SHSingleOptionMenuView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 45) style:SHSingleOptionMenuStyleBoxHeader];
    _menu.delegate = self;
    _menu.headerHorPadding = 15;
    _menu.headerItemSpace = 10;
    _menu.headerItemHeight = 25;
    
//    SHOptionMenuIndexPath *indexPath1 = [SHOptionMenuIndexPath indexPathForHeaderIndex:0 contentIndex:1];
//    SHOptionMenuIndexPath *indexPath2 = [SHOptionMenuIndexPath indexPathForHeaderIndex:1 contentIndex:1];
//    [_menu setupDefaultSelectedIndexPath:@[indexPath1, indexPath2]];
    [self.view addSubview:_menu];
}

#pragma mark - option menu header delegate

- (NSArray<SHSingleOptionMenuHeaderEntityModel *> *)menuHeaderItemsSource {
    NSMutableArray *entity = [NSMutableArray array];
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    for (NSString *title in titles) {
        SHSingleOptionMenuHeaderEntityModel *header = [[SHSingleOptionMenuHeaderEntityModel alloc] init];
        header.title = title;
        header.icon = @"filter_img";
        header.selectedIcon = @"selectd_filter_img";
        header.iconIsLeft = [titles.lastObject isEqualToString:title];
        
        [entity addObject:header];
    }
    
    return entity;
}

- (NSInteger)numberOfHeaderItemsCountForMenu:(SHSingleOptionMenuView *)menu {
    return 4;
}

- (SHSingleOptionMenuHeaderEntityModel *)menu:(SHSingleOptionMenuView *)menu headerEntityForIndex:(NSInteger)index {
    NSArray<SHOptionMenuIndexPath *> *selectedItems = [menu menuSelectedItemsWithHeaderIndex:index];
    SHSingleOptionMenuHeaderEntityModel *origin = [self menuHeaderItemsSource][index];
    if (selectedItems.count == 0) {
        return origin;
    }
    
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    NSString *title = [NSString stringWithFormat:@"%@---%ld", titles[index], selectedItems.firstObject.contentIndex];
    SHSingleOptionMenuHeaderEntityModel *new = [origin copy];
    new.title = title;
    return new;
}

- (NSInteger)menu:(SHSingleOptionMenuView *)menu numberOfContentItemsCountForHeaderIndex:(NSInteger)index {
    if (index == 0) {
        return 17;
    }
    
    return 5;
}

- (CGSize)menu:(SHSingleOptionMenuView *)menu itemSizeForIndexPath:(SHOptionMenuIndexPath *)indexPath {
    if (indexPath.headerIndex == 0) {
        return CGSizeMake(375, 40);
    }
    
    return CGSizeMake(150, 40);
}

- (UIView *)menu:(SHSingleOptionMenuView *)menu itemForIndexPath:(SHOptionMenuIndexPath *)indexPath reusableItem:(UIView *)item itemSup:(UIView *)sup {
    UILabel *actualItem = (UILabel *)item;
    if (!item) {
        actualItem = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
        actualItem.font = [UIFont systemFontOfSize:14];
        actualItem.textAlignment = NSTextAlignmentLeft;
    }
    
    actualItem.textColor = [UIColor orangeColor];
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    actualItem.text = [NSString stringWithFormat:@"%@---%ld", titles[indexPath.headerIndex], indexPath.contentIndex];
    
    if ([[menu menuSelectedItemsWithHeaderIndex:indexPath.headerIndex] containsObject:indexPath]) {
        actualItem.textColor = [UIColor redColor];
    }
    
    return actualItem;
}

- (void)menu:(SHSingleOptionMenuView *)menu didSelectedContentItemForIndexPath:(SHOptionMenuIndexPath *)indexPath {
    if (indexPath.headerIndex == 0) {
        NSSet *set = [NSSet setWithObject:@(indexPath.contentIndex)];
        [menu reloadContentItemsAtIndexs:set];
        return;
    }
    
//    [menu reloadHeaderItemWithTitle:title index:indexPath.headerIndex];
    NSSet *headerSet = [NSSet setWithObject:@(indexPath.headerIndex)];
    [menu reloadHeaderItemsWithIndexs:headerSet];
    
    NSSet *contentSet = [NSSet setWithObject:@(indexPath.contentIndex)];
    [menu reloadContentItemsAtIndexs:contentSet];
}

- (void)menu:(SHSingleOptionMenuView *)menu didClickBottomAction:(BOOL)isConfirm index:(NSInteger)headerIndex {
    if (!isConfirm) {
        return;
    }
    
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    NSArray<SHOptionMenuIndexPath *> *selectedItems = [menu menuSelectedItemsWithHeaderIndex:headerIndex];
    NSMutableString *title = [NSMutableString string];
    for (SHOptionMenuIndexPath *item in selectedItems) {
        [title appendFormat:@"%@---%ld,", titles[headerIndex], item.contentIndex];
    }
    
    if (selectedItems.count > 0) {
        [title deleteCharactersInRange:NSMakeRange(title.length - 1, 1)];
    }
    
    if (title.length == 0) {
        title = titles[headerIndex];
    }
    
//    [menu reloadHeaderItemWithTitle:title index:headerIndex];
}

- (BOOL)menu:(SHSingleOptionMenuView *)menu canMulSelectedForHeaderIndex:(NSInteger)index {
    return index == 0;
}

- (void)menu:(SHSingleOptionMenuView *)menu willDisplayHeaderItem:(UIButton *)btn index:(NSInteger)index {
    if (index < 3) {
        btn.titleEdgeInsets = UIEdgeInsetsZero;
        btn.imageEdgeInsets = UIEdgeInsetsZero;
        [btn layoutIfNeeded];
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.titleLabel.origin.x, 0, btn.titleLabel.origin.x);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -(btn.imageView.origin.x - btn.titleLabel.width - 2), 0, (btn.imageView.origin.x - btn.titleLabel.width - 2));
    }
}

@end
