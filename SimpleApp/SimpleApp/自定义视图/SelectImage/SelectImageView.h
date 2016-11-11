//
//  SelectImageView.h
//  SimpleCommon
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectImageView : UIView

@property (nonatomic, assign) NSInteger colNum;

@property (nonatomic, assign) NSInteger defaultImageIndex;

/**
 default height is 100
 */
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, strong) NSArray *source;

@end
