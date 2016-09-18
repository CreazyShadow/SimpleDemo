//
//  ScrapeView.m
//  SimpleApp
//
//  Created by wuyp on 16/6/28.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ScrapeView.h"

@interface ScrapeView()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ScrapeView

#pragma mark - init

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _textLabel.text = @"你个逗比";
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    _imageView.frame = self.bounds;
    _imageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_imageView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 触摸任意位置
    UITouch *touch = touches.anyObject;
    // 触摸位置在图片上的坐标
    CGPoint cententPoint = [touch locationInView:self.imageView];
    // 设置清除点的大小
    CGRect  rect = CGRectMake(cententPoint.x, cententPoint.y, 20, 20);
    // 默认是去创建一个透明的视图 UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    // 获取上下文(画板)
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把imageView的layer映射到上下文中
    [self.imageView.layer renderInContext:ref];
    // 清除划过的区域
    CGContextClearRect(ref, rect);
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的画板, (意味着图片在上下文中消失)
    UIGraphicsEndImageContext();
    self.imageView.image = image;
}

#pragma mark - override

- (id)valueForUndefinedKey:(NSString *)key {
    return [NSString stringWithFormat:@"not find the key:%@", key];
}

@end
