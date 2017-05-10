//
//  GcdViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/6/15.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "GcdViewController.h"

#import "SortHelper.h"

@interface GcdViewController ()

@property (nonatomic, strong) NSMutableDictionary *sourceDict;


@end

@implementation GcdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sourceDict = [[NSMutableDictionary alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testBarrier];
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

#pragma mark - 同步队列

- (void)mainQueueSync {
    
    //造成同步等待 卡死
    /*dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"-----main queue do something");
    });
     */
    
    //同一个queue 不能开启两个同步任务
    dispatch_queue_t queue = dispatch_queue_create("test queue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"main:%@ current:%@--1", [NSThread mainThread], [NSThread currentThread]);
        
        //此处会引起崩溃
        /*dispatch_sync(queue, ^{
            NSLog(@"sub");
        });*/
        
        NSLog(@"----");
    });
    
    NSLog(@"---end");
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

#pragma mark - NSOperation

- (void)syncOperation {
    
    dispatch_semaphore_t single = dispatch_semaphore_create(0);
    __block int count = 0;
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Thread---1");
        [NSThread detachNewThreadWithBlock:^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"Thread---1--");
            count++;
            if (count == 3) {
                dispatch_semaphore_signal(single);
            }
        }];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Thread---2");
        [NSThread detachNewThreadWithBlock:^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"Thread---2--");
            count++;
            if (count == 3) {
                dispatch_semaphore_signal(single);
            }
        }];
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Thread---3");
        [NSThread detachNewThreadWithBlock:^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"Thread---3---");
            count++;
            if (count == 3) {
                dispatch_semaphore_signal(single);
            }
        }];
    }];
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    [operationQueue addOperation:op1];
    [operationQueue addOperation:op2];
    [operationQueue addOperation:op3];
    
//    [operationQueue waitUntilAllOperationsAreFinished];
    [NSThread detachNewThreadWithBlock:^{
        dispatch_semaphore_wait(single, DISPATCH_TIME_FOREVER);
        NSLog(@"---end");
    }];
}

#pragma mark - 异步线程 同步执行

- (void)syncBlock {
    dispatch_semaphore_t single1 = dispatch_semaphore_create(0);
    dispatch_semaphore_t single2 = dispatch_semaphore_create(0);
    dispatch_semaphore_t single3 = dispatch_semaphore_create(0);
    [NSThread detachNewThreadWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"----thread1");
        dispatch_semaphore_signal(single1);
    }];
    
    [NSThread detachNewThreadWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----thread2");
        dispatch_semaphore_signal(single2);
    }];
    
    [NSThread detachNewThreadWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"----thread3");
        dispatch_semaphore_signal(single3);
    }];
    
    [NSThread detachNewThreadWithBlock:^{
        dispatch_semaphore_wait(single1, DISPATCH_TIME_FOREVER);
        NSLog(@"----thread1---end");
        dispatch_semaphore_wait(single2, DISPATCH_TIME_FOREVER);
        NSLog(@"----thread2---end");
        dispatch_semaphore_wait(single3, DISPATCH_TIME_FOREVER);
        NSLog(@"----thread3---end");
    }];
}

#pragma mark - barr

- (void)testBarrier {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"----1");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----2");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"-----4");
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3");
    });
}

@end
