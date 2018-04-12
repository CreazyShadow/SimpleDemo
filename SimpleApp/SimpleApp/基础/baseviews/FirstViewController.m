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
@property (nonatomic, strong) UIImageView *imv;

@property (nonatomic, strong) NSArray<SubModel *> *oldSource;
@property (nonatomic, strong) NSArray<SubModel *> *nowSource;

@property (nonatomic, strong) UIView *name;

@end

@implementation FirstViewController

@synthesize name = _name;

- (UIView *)name {
    if (!_name) {
        _name = [UIView new];
    }
    
    return _name;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FirstViewController";
    
    [self.view addSubview:self.imv];
    
    [self setupSubViews];
    
    [self.view addSubview:self.button1];
    
    self.view.circle = YES;
    
    [self setupSource];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    SecondViewController *second = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:second animated:YES];
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

- (UIImageView *)imv {
    if (!_imv) {
        _imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    }
    
    return _imv;
}

#pragma mark - 裁剪

/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
-(UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size{
    
    //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
    if (image.size.width*size.height <= image.size.height*size.width) {
        
        //以被剪裁图片的宽度为基准，得到剪切范围的大小
        CGFloat width  = image.size.width;
        CGFloat height = image.size.width * size.height / size.width;
        
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:image inRect:CGRectMake(0, 0, width, height)];
        
    }else{ //被切图片宽比例比高比例大，以图片高进行剪裁
        
        // 以被剪切图片的高度为基准，得到剪切范围的大小
        CGFloat width  = image.size.height * size.width / size.height;
        CGFloat height = image.size.height;
        
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:image inRect:CGRectMake((image.size.width -width)/2, 0, width, height)];
    }
    return nil;
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
-(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}

@end
