//
//  RenderViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/9/29.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "RenderViewController.h"

#import <CoreFoundation/CoreFoundation.h>

@interface RenderViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger circleCount;

@property (weak, nonatomic) IBOutlet UIButton *alphaBtn;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation RenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeAlpha];
}

#pragma mark - alpha
/**
 * opaque alpha 其中alpha < 1,opaque = NO; alpha >= 1,opaque = YES
 * Result = Source + Destination * (1 - SourceAlpha) 图层混合计算规则
 */

- (void)initializeAlpha {
    self.circleCount = 1;
    self.alphaBtn.alpha = 0.8;
    self.alphaBtn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
}

- (IBAction)alphaAction:(id)sender {
    self.alphaBtn.alpha = self.circleCount++ / 10.0;
}

#pragma mark - 图片 加载 解码 渲染
/**
 * PNG：加载时间比较长，解码时间比较短(xcode做了优化) JEPG：加载较快，解码比较麻烦
 * iOS延迟加载图片 先加载到内存，在渲染时才会进行解码渲染.
 *
 */


/**
 立即解码图片:绕过UIKit，通过ImageIO的方式进行解码
 */
- (UIImage *)imageIOLoadImage {
    NSURL *imgUrl = [NSURL fileURLWithPath:@""];
    NSDictionary *options = @{(__bridge id)kCGImageSourceShouldCache : @YES};
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imgUrl, NULL);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, (__bridge CFDictionaryRef)options);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CFRelease(source);
    
    return img;
}

- (IBAction)imageAction:(id)sender {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    UIImage *img = [UIImage imageWithContentsOfFile:file];
    NSData *data = UIImageJPEGRepresentation(img, 1);
    NSLog(@"%ld", (long)data.bytes / (1024 * 1024));
}

- (IBAction)cameraAction:(id)sender {
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        UIImage *img = info[UIImagePickerControllerOriginalImage];
        NSData *data = UIImageJPEGRepresentation(img, 0.5);
        NSLog(@"%f", ((long)data.length) / (1024.0 * 1024.0));
    }];
}

#pragma mark - getter setter

- (NSInteger)circleCount {
    if (_circleCount > 10) {
        _circleCount = 1;
    }
    
    return _circleCount;
}

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePickerController.delegate = self;
    }
    
    return _imagePickerController;
}

@end
