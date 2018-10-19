//
//  MasonryTableViewCell.m
//  SimpleApp
//
//  Created by wuyp on 16/8/22.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "MasonryTableViewCell.h"



@interface MasonryTableViewCell()

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *right;

@end

@implementation MasonryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor purpleColor];
//        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.title = [[UILabel alloc] init];
    _title.textColor = [UIColor purpleColor];
    _title.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_title];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(100);
    }];
    
    self.right = [[UILabel alloc] init];
    _right.textColor = [UIColor purpleColor];
    _right.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_right];
    
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(100);
    }];
}

- (void)setupLeft:(NSString *)left right:(NSString *)right {
    _title.text = left;
    _right.text = right;
}

@end
