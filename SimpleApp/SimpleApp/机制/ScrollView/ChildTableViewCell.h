//
//  ChildTableViewCell.h
//  SimpleApp
//
//  Created by wuyp on 2017/10/9.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *section;

@property (nonatomic, assign) NSInteger sectionNum;

@property (nonatomic, strong) NSMutableArray *source;

@property (nonatomic, copy) void(^reloadSection)(NSInteger section, CGFloat height);

@end
