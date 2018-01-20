//
//  AutoLayoutCell.m
//  SimpleApp
//
//  Created by wuyp on 2017/10/14.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "AutoLayoutCell.h"

@interface AutoLayoutCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *detailLbl;

@end

@implementation AutoLayoutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews {
    self.titleLbl = [[UILabel alloc] init];
    _titleLbl.font = [UIFont systemFontOfSize:15];
    _titleLbl.textColor = [UIColor redColor];
    _titleLbl.textAlignment = NSTextAlignmentLeft;
    _titleLbl.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_titleLbl];
    
    self.detailLbl = [[UILabel alloc] init];
    _detailLbl.font = [UIFont systemFontOfSize:12];
    _detailLbl.textColor = [UIColor blueColor];
    _detailLbl.textAlignment = NSTextAlignmentLeft;
    _detailLbl.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_detailLbl];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(15);
    }];
    
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleLbl);
        make.height.mas_equalTo(12);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)setupTitle:(NSString *)title detail:(NSString *)detail {
    self.titleLbl.text = title;
    self.detailLbl.text = detail;
}

@end
