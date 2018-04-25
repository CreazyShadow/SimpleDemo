//
//  SHSingleOptionMenuContentView.m
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/4/24.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "SHSingleOptionMenuContentView.h"

static NSInteger const kItemTag = 10;
static NSString *const kCellID = @"UICollectionViewCellIdentify";

static CGFloat const kTextLblLeftOrRightMargin = 0;

@interface SHSingleOptionMenuContentView() <
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SHSingleOptionMenuContentView

#pragma mark - life cycle(init)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    
    return self;
}

#pragma mark - init subviews

#pragma mark - event responder

#pragma mark - collection view delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(itemCountForMenuContentView:)]) {
        return [self.delegate itemCountForMenuContentView:self];
    }
    
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];

    UIView *old = [cell viewWithTag:kItemTag];
    if ([self.delegate respondsToSelector:@selector(menuContentView:itemForIndex:reusableItem:itemSup:)]) {
        UIView *content = [self.delegate menuContentView:self itemForIndex:indexPath.item reusableItem:old itemSup:cell.contentView];
        content.tag = kItemTag;
        if (!old) {
            [cell.contentView addSubview:content];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(itemSizeForMenuContentView:index:)]) {
        return [self.delegate itemSizeForMenuContentView:self index:indexPath.item];
    }
    
    return CGSizeMake(self.width, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(menuContentView:didSelectItem:)]) {
        [self.delegate menuContentView:self didSelectItem:indexPath.item];
    }
}

#pragma mark - public

- (void)reloadData {
    [self.collectionView reloadData];
}

- (UIView *)dequeueReusableItem {
    return nil;
}

#pragma mark - private

- (UILabel *)textLblWithCell:(UICollectionViewCell *)cell {
    UILabel *lbl = [cell viewWithTag:kItemTag];
    if (!lbl) {
        lbl = [[UILabel alloc] init];
        lbl.tag = kItemTag;
        lbl.font = [UIFont systemFontOfSize:16];
        lbl.textColor = [UIColor orangeColor];
        lbl.textAlignment = NSTextAlignmentLeft;
        
        [cell.contentView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, kTextLblLeftOrRightMargin, 0, kTextLblLeftOrRightMargin));
        }];
    }
    
    return lbl;
}

#pragma mark - getter & setter

- (CGFloat)expectHeight {
    return self.collectionView.contentSize.height;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
//        flowLayout.headerReferenceSize = CGSizeMake(0, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellID];
    }
    
    return _collectionView;
}

@end
