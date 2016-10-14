//
//  GcdViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/6/15.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "GcdViewController.h"

@interface GcdViewController ()

@property (nonatomic, strong) NSMutableDictionary *sourceDict;


@end

@implementation GcdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sourceDict = [[NSMutableDictionary alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testSetDictonaryValue];
}

#pragma mark - 多个列队同步控制

- (void)testManyRequest {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    for (int i = 0; i < 5; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(arc4random() % 3);
            NSLog(@"%d", i);
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
}

- (void)testSemaphore {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"------running-----%@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"-----completed-----%@", [NSThread currentThread]);
}

#pragma mark - 同时访问资源

- (void)testSetDictonaryValue {
    if (self.sourceDict.count > 0) {
        NSLog(@"%@", _sourceDict);
        return;
    }
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *str = [NSString stringWithFormat:@"%d", i];
            [self.sourceDict setObject:str forKey:str];
        });
    }
}

@end
