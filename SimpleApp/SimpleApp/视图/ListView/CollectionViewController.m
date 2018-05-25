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

@property (nonatomic, strong) UIView *operationView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.collectionView];
    
    [self.view insertSubview:self.operationView aboveSubview:self.collectionView];
}

#pragma mark - event

- (void)buttonAction:(UIButton *)btn {
    NSLog(@"----点击的按钮：%ld", btn.tag - 10);
}

- (void)operationGestureAction:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:self.view];
    static CGFloat startY = 0;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            startY = point.y;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat offset = point.y - startY;
            self.collectionView.contentOffset = CGPointMake(0, -offset - 64);
            NSLog(@"---offset:%lf", offset);
            gesture.view.top = 344 + offset;
        }
            break;
            
        default:
            break;
    }
    
    
//    NSLog(@"----开始滑动:%@", NSStringFromCGPoint(point));
}

#pragma mark - collectionview delegate & datasource

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(50, 0, 0, 0);
    }
    
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, 40);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.layer.borderWidth = 1;
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
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    header.layer.borderWidth = 3;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        UILabel *comment = [[UILabel alloc] init];
        comment.text = @"AAAAAAA";
        [header addSubview:comment];
        [comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header);
        }];

        header.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        header.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    
    return header;
}

#pragma mark - getter & setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.headerReferenceSize = CGSizeZero;
//        layout.footerReferenceSize = CGSizeZero;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"header"];
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

- (UIView *)operationView {
    if (!_operationView) {
        _operationView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * 7 + 64, kScreenWidth, 50)];
        _operationView.backgroundColor = [UIColor orangeColor];
        
        for (int i = 0; i < 5; i++) {
            UIButton *temp = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 5 * i, 0, kScreenWidth / 5, 50)];
            temp.tag = 10 + i;
            [temp setTitle:@"测试" forState:UIControlStateNormal];
            [temp addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_operationView addSubview:temp];
        }
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(operationGestureAction:)];
        [_operationView addGestureRecognizer:gesture];
    }
    
    return _operationView;
}

@end
