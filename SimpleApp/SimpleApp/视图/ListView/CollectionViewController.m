//
//  CollectionViewController.m
//  SimpleApp
//
//  Created by wuyp on 2018/1/10.
//  Copyright © 2018年 wuyp. All rights reserved.
//

#import "CollectionViewController.h"
#import "DemoCollectionViewCell.h"

@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - collectionview delegate & datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section * 2 + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *lbl = [cell.contentView viewWithTag:10];
    if (!lbl) {
        lbl = [[UILabel alloc] init];
        lbl.tag = 10;
        lbl.textColor = [UIColor orangeColor];
        lbl.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:lbl];
        
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(cell.contentView);
        }];
        
        NSLog(@"-----------复用");
    }
    
    lbl.text = [NSString stringWithFormat:@"AAAAA%ld--%ld", indexPath.section, indexPath.item];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    header.layer.borderColor = [UIColor redColor].CGColor;
    header.layer.borderWidth = 1;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 16)];
        comment.text = @"AAAAAAA";
        [header addSubview:comment];
        
        return header;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(370, 40);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(15, 0, 0, 0);
//}

#pragma mark - getter & setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 30);
        layout.minimumLineSpacing = 10;
//        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(20, 15, 25, 15);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.headerReferenceSize = CGSizeMake(0, 16);
        layout.minimumLineSpacing = 5;
//        layout.minimumInteritemSpacing = 12;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    
    return _collectionView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    
    return _maskView;
}

@end
