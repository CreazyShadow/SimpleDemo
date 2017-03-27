//
//  RayAnimation.h
//  SimpleApp
//
//  Created by wuyp on 2017/2/13.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RayAnimation<NSObject>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *eat;

@end

@interface RayAnimation : NSObject

- (void)createAnimation:(NSString *)name eat:(NSString *)eat;

- (void)introduce:(id<RayAnimation>)animation;

@end
