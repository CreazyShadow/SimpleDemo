//
//  TestRuntimeViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/5/25.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestRuntimeViewController.h"
//#import "Dog.h"
#import "Dog+Fly.h"
#import <Cat.h>

#import <objc/runtime.h>
#import <objc/message.h>

#import "ClassA.h"
#import "ClassB.h"

@interface TestRuntimeViewController ()

@end

@implementation TestRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self testAddMethod];
//    [self testDogFlyProperty];
//    [self testAddMethodWithRuntime];
    [self swizzleFunction];
    
    ClassA *a = [[ClassA alloc] init];
    [a print];
    
//    ClassB *b = [[ClassB alloc] init];
//    [b print];
}

#pragma mark - addMethod : 消息转发和添加

- (void)testAddMethod {
    Dog *dog = [[Dog alloc] init];
    [dog eat];
}

- (void)testAddMethodWithRuntime {
    IMP imp = class_getMethodImplementation([self class], @selector(sleep));
    BOOL success = class_addMethod([Cat class], NSSelectorFromString(@"sleep"), imp, "v@:");
    NSLog(@"add sleep method for Cat: %@", success ? @"success" : @"failed");
    
    Cat *cat = [[Cat alloc] init];
    ((void (*)(id,SEL))objc_msgSend)(cat, @selector(sleep));
}

- (void)sleep {
    NSLog(@"----sleep");
}

#pragma mark - category property

- (void)testDogFlyProperty {
    Dog *dog = [[Dog alloc] init];
    dog.flyType = @"curve fly";
    NSLog(@"dog fly type:%@", dog.flyType);
}

#pragma mark - swizzle

- (void)swizzleFunction {
    Method a = class_getInstanceMethod([ClassA class], NSSelectorFromString(@"print"));
    Method b = class_getInstanceMethod([ClassB class], NSSelectorFromString(@"print"));
    
    method_exchangeImplementations(a, b);
}

@end
