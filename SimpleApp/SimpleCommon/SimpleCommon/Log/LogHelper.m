//
//  LogHelper.m
//  SimpleCommon
//
//  Created by wuyp on 16/6/16.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "LogHelper.h"

@implementation LogHelper

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static LogHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)redirectSTD:(int)fd {
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *pipeReadHandle = [pipe fileHandleForReading];
    int pipeFileHandle = [[pipe fileHandleForWriting] fileDescriptor];
    dup2(pipeFileHandle, fd);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redirectNotificationHandle:) name:NSFileHandleReadCompletionNotification object:pipeReadHandle];
    [pipeReadHandle readInBackgroundAndNotify];
}

- (void)redirectNotificationHandle:(NSNotification *)nf {
    NSData *data = [[nf userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str __attribute__((unused)) = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [[nf object] readInBackgroundAndNotify];
}

- (dispatch_source_t)_startCapturingWritingToFD:(int)fd {
    int fildes[2];
    pipe(fildes);
    dup2(fildes[1], fd);
    close(fildes[1]);
    fd = fildes[0];
    char *buffer = malloc(1024);
    NSMutableData *data = [[NSMutableData alloc] init];
    fcntl(fd, F_SETFL, O_NONBLOCK);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, fd, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_cancel_handler(source, ^{
        free(buffer);
    });
    dispatch_source_set_event_handler(source, ^{
        @autoreleasepool {
            while (1) {
                ssize_t size = read(fd, buffer, 1024);
                if (size <= 0) {
                    break;
                }
                
                [data appendBytes:buffer length:size];
                if (size < 1024) {
                    break;
                }
            }
            
            NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    });
    
    dispatch_resume(source);
    return source;
}

#pragma mark - ASL读取日志

//+ (NSMutableArray *)allLogMessageForCurrentProcess {
//     
//}
@end
