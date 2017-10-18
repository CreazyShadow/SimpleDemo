//
//  ViewController.h
//  SimpleApp
//
//  Created by wuyp on 16/4/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

//extern NSString *test_key;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *webviewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;
@property (weak, nonatomic) IBOutlet UIView *container;

@end

