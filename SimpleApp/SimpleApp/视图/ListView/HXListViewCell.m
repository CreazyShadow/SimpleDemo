//
//  HXListViewCell.m
//  TZYJ_IPhone
//
//  Created by 邵运普 on 2017/12/12.
//

#import "HXListViewCell.h"

@interface HXListViewCell ()

@property (nonatomic, strong) UIView *lineView;
@end

@implementation HXListViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor purpleColor];
    }
    return _lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
