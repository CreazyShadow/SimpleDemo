//
//  FirstViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/6/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "GestureViewController.h"
#import "ScrapeView.h"
#import "TestWebviewViewController.h"
#import "DrawViewController.h"

#import <Person.h>
#import <objc/runtime.h>

#import "SubView.h"

#import "SubModel.h"

#import "MasonryViewController.h"

#import "HealthInfoModel.h"

#define bytesPerMB 1048576.0f
#define bytesPerPixel 4.0f
#define pixelsPerMB ( bytesPerMB / bytesPerPixel ) // 262144 pixels, for 4 bytes per pixel.
#define destTotalPixels kDestImageSizeMB * pixelsPerMB
#define tileTotalPixels kSourceImageTileSizeMB * pixelsPerMB
#define destSeemOverlap 2.0f // the numbers of pixels to overlap the seems where tiles meet.

@interface FirstViewController ()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) ScrapeView *scrapeView;
@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) NSArray<SubModel *> *oldSource;
@property (nonatomic, strong) NSArray<SubModel *> *nowSource;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FirstViewController";
    
    [self setupSubViews];
    
    [self.view addSubview:self.button1];
    
    self.view.circle = YES;
    
    [self setupSource];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.nowSource[0].isBoy = YES;
    self.nowSource[0].name = @"danny";
    NSLog(@"----");
}

#pragma mark - override

- (void)print {
    NSLog(@"first view ------print");
}

#pragma mark - init

- (void)setupSubViews {
    _label = [[UILabel alloc] init];
    [self.view addSubview:_label];
    
    _label.backgroundColor = [UIColor purpleColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:18];
    _label.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(100);
    }];
}

#pragma mark - event responder

- (void)clickButton1 {
#ifdef __IPHONE_7_0
    [self.label.text drawInRect:self.label.bounds withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _label.textAlignment = NSTextAlignmentCenter;
#else
    [self.label.text drawInRect:self.label.bounds withFont:_label.font lineBreakMode:NSLineBreakByTruncatingMiddle alignment:NSTextAlignmentCenter];
#endif
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)labelPanGes:(UIPanGestureRecognizer *)ges {
    
}

#pragma mark - getter & setter

- (ScrapeView *)scrapeView {
    if (!_scrapeView) {
        _scrapeView = [[ScrapeView alloc] init];
    }
    
    return _scrapeView;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 180, 200, 40)];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 1;
    }
    
    return _stackView;
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 100, 30)];
        _button1.backgroundColor = [UIColor purpleColor];
        [_button1 setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        _button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        //        [_button1 setTitle:@"button1" forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button1;
}

#pragma mark - test

- (void)setupSource {
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0 ; i < 3; i++) {
        SubModel *p = [[SubModel alloc] init];
        p.name = [NSString stringWithFormat:@"jack%d", i];
        p.phone = @"18516518888";
        p.isBoy = NO;
        [temp addObject:p];
    }
    
    self.nowSource = [temp copy];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: _nowSource];
    self.oldSource = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)copySource {
    
}

@end
