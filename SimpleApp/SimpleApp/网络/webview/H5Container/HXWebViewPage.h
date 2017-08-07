//
//  HXWebViewPage.h
//  SimpleApp
//
//  Created by BYKJ on 2017/8/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXWebViewActionHandler.h"
#import "HXWebViewLoadInterrupt.h"

@interface HXWebViewPage : UIViewController

- (void)openUrl:(NSString *)url actionHandler:(NSArray *)handler interrupt:(HXWebViewLoadInterrupt *)interrupt;

@end
