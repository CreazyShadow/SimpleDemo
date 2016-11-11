//
//  SelectImageItemView.m
//  SimpleCommon
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "SelectImageItemView.h"

@interface SelectImageItemView()

@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@end

@implementation SelectImageItemView

- (IBAction)delAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (self.delEvent) {
        self.delEvent(weakSelf);
    }
}

- (void)setBackgroundImage:(id)backgroundImage {
    _backgroundImage = backgroundImage;
    
    if ([backgroundImage isKindOfClass:[NSString class]]) {
        [self.backgroundImageView sd_setImageWithURL:backgroundImage];
    } else if ([backgroundImage isKindOfClass:[UIImage class]]) {
        self.backgroundImageView.image = backgroundImage;
    }
}

@end
