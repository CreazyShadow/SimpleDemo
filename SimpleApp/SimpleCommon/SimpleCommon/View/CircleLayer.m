//
//  CircleLayer.m
//  SimpleCommon
//
//  Created by wuyp on 16/7/6.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "CircleLayer.h"

@interface CircleLayer()

@property (nonatomic, strong) id displayContent;


@end

@implementation CircleLayer

- (instancetype)initWithDisplayContent:(id)content withFrame:(CGRect)frame{
    if (self = [super init]) {
        self.frame = frame;
        self.displayContent = content;
        self.masksToBounds = YES;
    }
    
    return self;
}

- (void)drawInContext:(CGContextRef)context {
    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    
    [self renderContent];
    
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}

- (void)renderContent {
    if ([self.displayContent isKindOfClass:[NSString class]] && [self.displayContent length] > 0) {
        
        NSString *temp = (NSString *)self.displayContent;
        NSDictionary *attributes = @{
                                     NSFontAttributeName : [UIFont systemFontOfSize:14],
                                     NSForegroundColorAttributeName : [UIColor redColor]
                                     };
        
        [temp drawInRect:self.bounds withAttributes:attributes];
    } else if ([self.displayContent isKindOfClass:[UIImage class]]) {
        
        UIImage *temp = (UIImage *)self.displayContent;
        [temp drawInRect:self.bounds];
    }
}

@end
