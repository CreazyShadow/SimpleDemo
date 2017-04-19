//
//  TapAViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/31.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "TapAViewController.h"

#import "Aview.h"
#import "Bview.h"

@interface TapAViewController ()

@property (nonatomic, strong) Aview *viewA;
@property (nonatomic, strong) Bview *viewB;

@end

@implementation TapAViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewA = [[Aview alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    _viewA.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *tapA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapAction)];
    [_viewA addGestureRecognizer:tapA];
    [self.view addSubview:_viewA];
    
    self.viewB = [[Bview alloc] initWithFrame:CGRectMake(20, 120, 40, 40)];
    _viewB.backgroundColor = [UIColor greenColor];
//    _viewB.userInteractionEnabled = NO;
    
    UITapGestureRecognizer *tapB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bTapAction)];
//    [_viewB addGestureRecognizer:tapB];
    [self.view addSubview:_viewB];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 100, 30)];
    [self.view addSubview:field];
    field.backgroundColor = [UIColor redColor];
    field.placeholder = @"12345";
    
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"doc"];
    NSURL *url = [NSURL fileURLWithPath:file];
}

- (void)aTapAction {
    NSLog(@"----tap A----");
}

- (void)bTapAction {
    NSLog(@"----tap B----");
}

- (void)tapAction {
    NSLog(@"----super tap----");
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
