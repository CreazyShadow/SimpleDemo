//
//  OperationQueueViewController.m
//  SimpleApp
//
//  Created by wuyp on 2017/3/17.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "OperationQueueViewController.h"

@interface OperationQueueViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation OperationQueueViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - init subviews
- (void)setupSubViews {
    
}

#pragma mark - event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self semaphore];
}

- (void)invocationDoSomething:(id)data {
    NSLog(@"data:%@\n mainThread:%@\n currentThread:%@", data, [NSThread mainThread], [NSThread currentThread]);
}

#pragma mark - OperationQueue

- (void)testInvocationOperation {
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationDoSomething:) object:@"data"];
    [self.operationQueue addOperation:invocation]; //会新开线程
    
    [invocation start];// 在invocation被添加的线程中执行
}

- (void)blockInvocation {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    [blockOperation addExecutionBlock:^{
        
    }];
    blockOperation.completionBlock = ^ {
        
    };
}

#pragma mark - 信号量

- (void)semaphore {
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    for (int i = 0; i < 5; i++) {
        [NSThread detachNewThreadWithBlock:^{
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            NSLog(@"-----thread%d", i);
            dispatch_semaphore_signal(sem);
        }];
    }
}

#pragma mark - network

#pragma mark - private

#pragma mark - getter & setter

@end
