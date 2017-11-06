//
//  UIScrollView+Multiple.m
//  SimpleApp
//
//  Created by wuyp on 2017/11/6.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "UIScrollView+Multiple.h"

static void *needMultipleScrollKey = &needMultipleScrollKey;
static void *scrollOffsetKey = &scrollOffsetKey;
static void *isSuperKey = &isSuperKey;

@implementation UIScrollView (Multiple)

#pragma mark - dynamic property

- (BOOL)needMultipleScroll {
    return [objc_getAssociatedObject(self, needMultipleScrollKey) boolValue];
}

- (void)setNeedMultipleScroll:(BOOL)needMultipleScroll {
    NSNumber *value = [NSNumber numberWithBool:needMultipleScroll];
    objc_setAssociatedObject(self, needMultipleScrollKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ScrollOffsetState)offsetState {
    return [objc_getAssociatedObject(self, scrollOffsetKey) intValue];
}

- (void)setOffsetState:(ScrollOffsetState)offsetState {
    NSNumber *value = [NSNumber numberWithInt:offsetState];
    objc_setAssociatedObject(self, scrollOffsetKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSuperScroll {
    return [objc_getAssociatedObject(self, isSuperKey) boolValue];
}

- (void)setIsSuperScroll:(BOOL)isSuperScroll {
    NSNumber *value = [NSNumber numberWithBool:isSuperScroll];
    objc_setAssociatedObject(self, isSuperKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - gesture method

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.needMultipleScroll) {
        return YES;
    }
    
    return NO;
}

@end
