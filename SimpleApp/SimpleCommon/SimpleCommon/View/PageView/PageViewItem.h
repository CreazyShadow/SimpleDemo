//
//  YZTPageViewItem.h
//  popDemo
//
//  Created by chenlehui on 16/4/28.
//  Copyright © 2016年 chenlehui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewItem : UIView

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

- (instancetype)initWithResuseIndetifier:(NSString *)reuseIdentifier;

@end
