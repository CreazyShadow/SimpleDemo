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
    
    Class monkey_cls = [monkey class];                      // 类对象
    Class monkey_meta = object_getClass(monkey_cls);        //meta 对象
    Class monkey_meta_ = objc_getMetaClass("Monkey_sub");   //meta 对象
    Class monkey_root_meta = object_getClass(monkey_meta);  //meta的元类对象 --- 根类对象 root class object
    NSLog(@"monkey类总结: instance:%p, class:%p, meta:%p-%p, meta meta|root:%p", monkey, monkey_cls, monkey_meta, monkey_meta_, monkey_root_meta);
    
    NSObject *obj = [[NSObject alloc] init];
    Class obj_cls = [obj class];
    Class obj_meta = object_getClass(obj_cls);
    Class obj_root_meta = object_getClass(obj_meta);
    NSLog(@"NSObject类总结： instance:%p, class:%p, meta:%p, meta meta|root:%p", obj, obj_cls, obj_meta, obj_root_meta);
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
