//
//  AttributeViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/27.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "AttributeViewController.h"

#import <math.h>

@interface AttributeViewController ()

@end

@implementation AttributeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *a = @"123";
    NSString *b = @"abc";
    [self swap:a b:b];
}

#pragma mark - network

#pragma mark - __attribute__

//__attribute__ ((warn_unused_result)) 没有使用返回值时会有警告
- (BOOL)isInteger:(NSNumber *)num __attribute__((warn_unused_result))
{
    CGFloat value = num.floatValue;
    if ((NSInteger)(value) == value) {
        return YES;
    }
    
    return NO;
}

//__attribute__ ((availability))
- (BOOL)containObject:(id)obj __attribute__((availability(ios, introduced=2_0, deprecated=7_0,message="")))
{
    return self.hash == [obj hash];
}

//__attribute__ ((no_return))
- (void) __attribute__((noreturn))runloop {
    while(1) {
        
    }
}

//__attribute__((format()))

//__attribute__((constructor)) 在main函数之前调用   __attribute__((destructor))在main之后调用
__attribute__((constructor)) void before_main() {
    NSLog(@"before main");
}

__attribute__((destructor)) void after_main() {
    NSLog(@"after main");
}

//__attribute__((cleanup(方法名))) 在变量作用域结束时调用方法 变量必须为strong不然会类型不匹配
void endFunction(__strong NSString **str) {
    NSLog(@"%@", *str);
}

static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}

- (void)swap:(NSString *)a b:(NSString *)b {
    __strong NSString *temp __attribute__((cleanup(endFunction), unused));
    temp = a;
    a = b;
    b = temp;
    
    {
        //unused 为了block未使用警告
        __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^{
            NSLog(@"I'm dlying....");
        };
    }
}

#pragma mark - getter & setter

@end
