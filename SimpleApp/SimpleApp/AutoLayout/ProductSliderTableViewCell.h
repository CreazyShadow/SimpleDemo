//
//  ProductSliderTableViewCell.h
//  SimpleApp
//
//  Created by wuyp on 16/9/20.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Model : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *event;

+ (NSArray *)testSource:(NSInteger)count;

@end

@interface ProductSliderTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<Model *> *source;

/**
 左标当前选中的值:在source中的位置
 */
@property (nonatomic, assign) NSInteger leftSelectedIndex;

/**
 右标当前选中的值:在source中的位置
 */
@property (nonatomic, assign) NSInteger rightSelectedIndex;


/**
 坐标选择完成的事件：参数 选中的index
 */
@property (nonatomic, copy) void(^leftSelectedCompletionAction)(NSInteger index);


/**
 右标选择完成的事件：参数 选中的index
 */
@property (nonatomic, copy) void(^rightSelectedCompletionAction)(NSInteger index);

@end
