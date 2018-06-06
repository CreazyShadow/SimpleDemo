//
//  ReusingCell.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/28.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ReusingCell.h"

@interface ReusingCell()

@property (nonatomic, strong) UILabel *nameLbl;

@end

@implementation ReusingCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.textColor = [UIColor purpleColor];
        [self.contentView addSubview:_nameLbl];
        [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [GlobalInstance shareInstance].count++;
    }
    
    return self;
}


#pragma mark - init sub views

#pragma mark - event

#pragma mark - public

#pragma mark - private

#pragma mark - getter & setter

- (void)setName:(NSString *)name {
    _name = name;
    
    _nameLbl.text = name;
}

@end
