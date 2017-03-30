//
//  BaseHeaderViewController.h
//  SimpleApp
//
//  Created by wuyp on 2017/3/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHeaderViewController : UIViewController

@property (nonatomic, strong) NSArray<NSString *> *headerSource;

- (void)selectHeaderAction:(NSInteger)index;

@end
