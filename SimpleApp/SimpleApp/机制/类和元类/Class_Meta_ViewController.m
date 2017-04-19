//
//  Class_Meta_ViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/4/19.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "Class_Meta_ViewController.h"

#import "Animation_super.h"

#import <objc/runtime.h>

@interface Class_Meta_ViewController ()

@end

@implementation Class_Meta_ViewController

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
    Animation_super *animation = [[Animation_super alloc] init];
    Monkey_sub *monkey = [[Monkey_sub alloc] init];
    Tiger_sub *tiger = [[Tiger_sub alloc] init];
    
    Class monkey_sub = object_getClass(monkey);
    Class ani = object_getClass(animation);
    Class tig_sub = object_getClass(tiger);
    
    Class monkey_meta = objc_getMetaClass("Monkey_sub");
    Class tiger_meta = objc_getMetaClass("Tiger_sub");
    Class anim_meta = objc_getMetaClass("Animation_super");
    
    
    NSLog(@"%p--%p", class_getSuperclass(monkey_meta), anim_meta);
    
    NSLog(@"%p---%p---%p",object_getClass([NSObject new]) , object_getClass(object_getClass([NSObject new])), objc_getMetaClass("NSObject"));
}

#pragma mark - network

#pragma mark - private

- (void)print:(Class)cls {
    int i = 0;
    Class temp = cls;
    while (i++ < 10) {
        NSLog(@"%@", temp);
        
    }
}

#pragma mark - getter & setter

@end
