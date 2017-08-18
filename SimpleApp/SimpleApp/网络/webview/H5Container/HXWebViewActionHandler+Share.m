//
//  HXWebViewActionHandler+Share.m
//  SimpleApp
//
//  Created by BYKJ on 2017/8/11.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "HXWebViewActionHandler+Share.h"

@implementation HXWebViewActionHandler (Share)

- (void)js_share {
    NSLog(@"---- share");
}

- (void)js_shareEvent {
    NSLog(@"---- share event");
}

- (void)sendCommentRequest {
    NSLog(@"-----");
}

#pragma mark - 相关业务逻辑

- (void)js_showShareDialog {
    //1....show
    //2....填写信息
    //3....发布
    [self sendCommentRequest];
}

@end
