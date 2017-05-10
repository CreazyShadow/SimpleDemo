
//
//  ANotificationViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "ANotificationViewController.h"

#import "BNotificationViewController.h"
#import "NotificationObject.h"

#import <objc/runtime.h>

@interface ANotificationViewController ()

@property (nonatomic, strong) NotificationObject *obj;

@end

@implementation ANotificationViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.obj = [[NotificationObject alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"notification" object:nil];
    
    [self.obj addObserver:self forKeyPath:@"phone" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    BNotificationViewController *vc = [[BNotificationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)receiveNotification:(NSNotification *)nc {
    NSLog(@"----receive notification%@", nc.object);
}

- (void)selectHeaderAction:(NSInteger)index {
    switch (index) {
        case 0:
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            break;
            
        case 1:
        {
            self.obj.name = @"jack";
            self.obj.phone = @"18516518602";
        }
            break;
            
        case 2:
        {
            
        }
            break;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"old:%@  new%@", change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
