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

@interface TestCustomViewController ()<SingleOptionMenuHeaderDelegate, SingleOptionMenuDelegate>

@property (nonatomic, strong) SHSingleOptionMenuHeaderView *header;
@property (nonatomic, strong) SHSingleOptionMenuView *menu;

@property (nonatomic, strong) NSArray<SHOptionMenuHeaderItemEntityModel *> *source;

@end

@implementation TestCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self addOptionHeaderView];
    [self addOptionMenuView];
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

- (void)addOptionHeaderView {
    [self.view addSubview:self.header];
}

- (void)addOptionMenuView {
    self.menu = [[SHSingleOptionMenuView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 45) style:SHSingleOptionMenuStyleBoxHeader];
    _menu.delegate = self;
    _menu.headerHorPadding = 15;
    _menu.headerItemSpace = 10;
    _menu.headerItemHeight = 25;

    SHOptionMenuIndexPath *indexPath1 = [SHOptionMenuIndexPath indexPathForHeaderIndex:0 contentIndex:1];
    SHOptionMenuIndexPath *indexPath2 = [SHOptionMenuIndexPath indexPathForHeaderIndex:1 contentIndex:1];
    [_menu setupDefaultSelectedIndexPath:@[indexPath1, indexPath2]];
    [self.view addSubview:_menu];
}

#pragma mark - source

- (NSArray<SHOptionMenuHeaderItemEntityModel *> *)source {
    if (!_source) {
        NSMutableArray *entity = [NSMutableArray array];
        NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
        for (NSString *title in titles) {
            SHOptionMenuHeaderItemEntityModel *header = [[SHOptionMenuHeaderItemEntityModel alloc] init];
            header.title = title;
            header.icon = @"filter_img";
            header.selectedIcon = @"selectd_filter_img";
            header.iconIsLeft = [titles.lastObject isEqualToString:title];
            NSInteger idx = [titles indexOfObject:title];
            idx = idx == 3 ? idx : 1;
            header.group = [NSString stringWithFormat:@"group%ld", idx];
            
            [entity addObject:header];
        }
        
        _source = [entity copy];
    }
    
    return _source;
}

#pragma mark - SingleOptionMenuHeaderDelegate

- (NSInteger)numberOfItemsCountInHeader:(SHSingleOptionMenuHeaderView *)header {
    return self.source.count;
}

- (SHOptionMenuHeaderItemEntityModel *)itemEntityModelForIndex:(NSInteger)index inHeader:(SHSingleOptionMenuHeaderView *)header {
    return self.source[index];
}

- (void)willDisplayMenuHeader:(SHSingleOptionMenuHeaderView *)header item:(SHSingleOptionMenuHeaderItemView *)item index:(NSInteger)index {
    NSLog(@"------ will display item: %ld", index);
}

- (void)menuHeader:(SHSingleOptionMenuHeaderView *)header didClickItem:(SHSingleOptionMenuHeaderItemView *)item index:(NSInteger)index isChangeTab:(BOOL)isChangeTab {
    NSLog(@"------ click menu item: %ld", index);
    
    if (index == 3) {
        [header reloadItemsWithIndexs:[NSSet setWithObject:@(index)]];
    }
}



#pragma mark - option menu delegate

- (NSInteger)numberOfHeaderItemsCountForMenu:(SHSingleOptionMenuView *)menu {
    return self.source.count;
}

- (SHOptionMenuHeaderItemEntityModel *)menu:(SHSingleOptionMenuView *)menu headerEntityForIndex:(NSInteger)index {
    NSArray<SHOptionMenuIndexPath *> *selectedItems = [menu menuSelectedItemsWithHeaderIndex:index];
    SHOptionMenuHeaderItemEntityModel *origin = self.source[index];
    if (selectedItems.count == 0) {
        return origin;
    }

    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    NSString *title = [NSString stringWithFormat:@"%@---%ld", titles[index], selectedItems.firstObject.contentIndex];
    SHOptionMenuHeaderItemEntityModel *new = [origin copy];
    new.title = title;
    return new;
}

- (NSInteger)menu:(SHSingleOptionMenuView *)menu numberOfContentItemsCountForHeaderIndex:(NSInteger)index {
    return 6;
}

- (BOOL)menu:(SHSingleOptionMenuView *)menu canMulSelectedForHeaderIndex:(NSInteger)index {
    return index == 0;
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

    NSSet *contentSet = [NSSet setWithObject:@(indexPath.contentIndex)];
    [menu reloadContentItemsAtIndexs:contentSet];
}

- (void)menu:(SHSingleOptionMenuView *)menu didClickBottomAction:(BOOL)isConfirm index:(NSInteger)headerIndex {
    if (!isConfirm) {
        return;
    }
}

- (void)menu:(SHSingleOptionMenuView *)menu willDisplayHeaderItem:(UIButton *)btn index:(NSInteger)index {
//    if (index < 3) {
//        btn.titleEdgeInsets = UIEdgeInsetsZero;
//        btn.imageEdgeInsets = UIEdgeInsetsZero;
//        [btn layoutIfNeeded];
//
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.titleLabel.origin.x, 0, btn.titleLabel.origin.x);
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -(btn.imageView.origin.x - btn.titleLabel.width - 2), 0, (btn.imageView.origin.x - btn.titleLabel.width - 2));
//    }
}

#pragma mark - getter & setter

- (SHSingleOptionMenuHeaderView *)header {
    if (!_header) {
        _header = [[SHSingleOptionMenuHeaderView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 45) style:SHMenuHeaderStyleCube];
        _header.backgroundColor = [UIColor whiteColor];
        _header.itemSpace = 10;
        _header.itemHeight = 25;
        _header.horPadding = 15;
        _header.delegate = self;
        NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:1];
        _header.defaultSelectedItems = set;
    }
    
    return _header;
}

@end
