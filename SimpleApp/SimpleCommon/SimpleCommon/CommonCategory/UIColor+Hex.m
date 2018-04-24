//
//  UIColor+Hex.m
//  imoffice
//
//  Created by zhanghao on 14-9-11.
//  Copyright (c) 2014年 IMO. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString length] < 6)
        return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];

    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexNumber:(NSUInteger)hexColor {
    float r = ((hexColor>>16) & 0xFF) / 255.0f;
    float g = ((hexColor>>8) & 0xFF) / 255.0f;
    float b = (hexColor & 0xFF) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}
    
+ (CAGradientLayer *)gradualChangingColor:(UIView *)view fromColor:(NSString *)fromColor toColor:(NSString *)toColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor hexStringToColor:fromColor].CGColor, (__bridge id)[UIColor hexStringToColor:toColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0, @1];
    return gradientLayer;
}

@end
