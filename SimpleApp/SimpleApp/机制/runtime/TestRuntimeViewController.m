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

#import "Runtime_Super.h"
#import "Runtime_Sub.h"

@interface TestRuntimeViewController ()

@end

@implementation TestRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self testRuntimeSuper];
    [self testPrivateClassProtected];
}

#pragma mark - RuntimeSuper And Sub

- (void)testRuntimeSuper {
    Runtime_Super *sup = [[Runtime_Super alloc] init];
    Runtime_Sub *sub = [[Runtime_Sub alloc] init];
    
    id id_sup __attribute__((unused)) = sup;
    id id_sub __attribute__((unused)) = sub;
    
    [id_sub addObject:@"1"];
}

#pragma mark - private class protected

- (void)testPrivateClassProtected {
    Class cls = NSClassFromString(@"Runtime_Super_Inner_Class");
    id instance = [[cls alloc] init];
    [instance setValue:@"jack" forKey:@"name"];
    BOOL value = ((BOOL(*)(id, SEL))objc_msgSend)(instance, NSSelectorFromString(@"method_1"));
    NSLog(@"%d", value);
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

#pragma mark - 属性

- (NSArray *)allKeyPath:(Class)cls {
    unsigned int count;
    const objc_property_t *props = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(props[i]);
        Class sub = NSClassFromString([NSString stringWithUTF8String:name]);
        [self allKeyPath:sub];
    }
    
    return nil;
}

@end
