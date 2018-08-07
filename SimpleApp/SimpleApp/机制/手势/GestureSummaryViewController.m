//
//  GestureSummaryViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/1/11.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "GestureSummaryViewController.h"

#import "GestureSummary_ResponseTime.h"
#import "RayMenuScrollView.h"

@interface GestureSummaryViewController ()

@property (nonatomic, strong) UIView *levelMenu;
@property (nonatomic, strong) RayMenuScrollView *actualLevelMenu;

@end

@implementation GestureSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.levelMenu];
}

- (void)gestureAction:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:self.view];
    if (point.y == 0) {
        return;
    }
    
    NSLog(@"---------pan gesutre");
}

- (UIView *)levelMenu {
    if (!_levelMenu) {
        _levelMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 45)];
        _levelMenu.layer.borderColor = [UIColor greenColor].CGColor;
        _levelMenu.layer.borderWidth = 1;
        
        RayMenuScrollView *menu = [[RayMenuScrollView alloc] initWithFrame:_levelMenu.bounds];
        menu.source = @[@"测试1", @"测试2", @"测试3", @"测试4", @"测试5", @"测试6", @"测试7", @"测试8", @"测试9", @"测试10"];
        self.actualLevelMenu = menu;
        [_levelMenu addSubview:menu];
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
        [_levelMenu addGestureRecognizer:gesture];
    }
    
    return _levelMenu;
}

@end
