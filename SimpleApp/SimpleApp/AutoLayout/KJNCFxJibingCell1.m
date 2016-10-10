//
//  KJNCFxJibingCell1.m
//  anyouyun
//
//  Created by hychou on 16/9/17.
//  Copyright © 2016年 ANSCloud. All rights reserved.
//

#import "KJNCFxJibingCell1.h"

@interface KJNCFxJibingCell1 ()

@property NSMutableArray *lblArrs;
@property NSMutableArray *lines;
@property UIView *content;
@property UIView *lineTop;
@property UIView *lineBottom;

@end

@implementation KJNCFxJibingCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.titles = @[@"日龄", @"饲养天数", @"腹部占比", @"咳嗽占比"];
        
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
        
        self.lineTop = [UIView new];
        self.lineTop.backgroundColor = [UIColor whiteColor];
        [self.content addSubview:self.lineTop];
        self.lineBottom = [UIView new];
        self.lineBottom.backgroundColor = [UIColor whiteColor];
        [self.content addSubview:self.lineBottom];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    CGFloat height = self.frame.size.height;
    CGFloat cellWidth = (kScreenWidth - 30) / self.titles.count;
    CGFloat cellHeight = height - 10;
    self.content.frame = CGRectMake(15, 10, kScreenWidth - 30, cellWidth);
    
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
    
    self.lineTop.frame = CGRectMake(0, 0, cellWidth * 4, 1);
    self.lineBottom.frame = CGRectMake(0, cellHeight - 1, cellWidth * 4, 1);
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    for (int i = 0; i < titles.count && self.lblArrs.count; i++) {
        _lblArrs[i] = titles[i];
    }
}

@end
