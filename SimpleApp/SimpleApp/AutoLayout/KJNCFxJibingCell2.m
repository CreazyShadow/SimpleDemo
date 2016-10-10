//
//  KJNCFxJibingCell2.m
//  anyouyun
//
//  Created by hychou on 16/9/17.
//  Copyright © 2016年 ANSCloud. All rights reserved.
//

#import "KJNCFxJibingCell2.h"

@interface KJNCFxJibingCell2 ()
@property NSArray *titles;
@property NSMutableArray<UILabel *> *lblArrs;
@property NSMutableArray *lines;
@property UIView *content;
@property UIView *lineBottom;
@end

@implementation KJNCFxJibingCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.titles = @[@"", @"", @"", @""];
        
        self.content = [UIView new];
        [self addSubview:self.content];
        self.lblArrs = [NSMutableArray array];
        for (NSString *title in self.titles) {
            UILabel *lblTitle = [UILabel new];
            lblTitle.text = title;
            lblTitle.font = [UIFont systemFontOfSize:12];
            lblTitle.textColor = [UIColor lightTextColor];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            [self.content addSubview:lblTitle];
            [self.lblArrs addObject:lblTitle];
        }
        self.lines = [NSMutableArray array];
        for (int i=0; i<=self.titles.count; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor whiteColor];
            [self.content addSubview:line];
            [self.lines addObject:line];
        }
        
        self.lineBottom = [UIView new];
        self.lineBottom.backgroundColor = [UIColor whiteColor];
        [self.content addSubview:self.lineBottom];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    CGFloat height = self.frame.size.height;
    CGFloat cellWidth = (kScreenWidth - 30) / self.titles.count;
    CGFloat cellHeight = height;
    self.content.frame = CGRectMake(15, 0, kScreenWidth - 30, cellWidth);
    
    int i = 0;
    for (UILabel *lbl in self.lblArrs) {
        lbl.frame = CGRectMake(cellWidth * i, 0, cellWidth, cellHeight);
        i++;
    }
    i = 0;
    for (UIView *line in self.lines) {
        line.frame = CGRectMake(cellWidth * i, 0, 1, cellHeight);
        i++;
    }
    
    self.lineBottom.frame = CGRectMake(0, cellHeight - 1, cellWidth * 4, 1);
}

- (void)setSource:(NSArray<NSString *> *)source {
    for (int i = 0; i < _lblArrs.count && source.count; i++) {
        _lblArrs[i].text = source[i];
    }
}

@end
