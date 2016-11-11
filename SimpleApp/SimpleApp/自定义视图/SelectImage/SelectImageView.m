//
//  SelectImageView.m
//  SimpleCommon
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SelectImageView.h"
#import "SelectImageItemView.h"

static const CGFloat kItemSpace = 5;
static const CGFloat kInsetValue = 10;

@interface SelectImageView()

@property (nonatomic, strong) NSMutableArray<SelectImageItemView *> *itemSourceArray;

@end

@implementation SelectImageView

#pragma mark - init subviews

- (void)setSource:(NSArray *)source {
    _source = source;
    
    for (id item in source) {
        //add subviews
        SelectImageItemView *temp = [SelectImageItemView loadFromNib];
      
        temp.backgroundImage = item;
     
        [self addSubview:temp];
        
        [self.itemSourceArray addObject:temp];
    }
    
    SelectImageItemView *addItem = [[SelectImageItemView alloc] init];
    [self addSubview:addItem];
    [self.itemSourceArray addObject:addItem];
}

#pragma mark - setter & getter

- (NSMutableArray *)itemSourceArray {
    if (!_itemSourceArray) {
        _itemSourceArray = [NSMutableArray array];
    }
    
    return _itemSourceArray;
}

#pragma mark - private clear source

- (void)clearSource {
    for (SelectImageItemView *item in _itemSourceArray) {
        [item removeFromSuperview];
    }
    
    [_itemSourceArray removeAllObjects];
}


@end
