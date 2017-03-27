//
//  SessionCustomeProtocol.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "SessionCustomeProtocol.h"

#import <Objc/message.h>
#import <objc/runtime.h>

static NSString * const kCustomkey = @"myCustomKey";

@interface SessionCustomeProtocol() <NSURLSessionDataDelegate,
NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLResponse *urlResponse;
@property (nonatomic, strong) NSMutableData *receivedData;

@end

@implementation SessionCustomeProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([NSURLProtocol propertyForKey:kCustomkey inRequest:request]) {
        return NO;
    }
    
    NSString *scheme = request.URL.scheme;
    if ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
        [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading {
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:kCustomkey inRequest:mutableRequest];
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:nil];
    self.dataTask = [defaultSession dataTaskWithRequest:mutableRequest];
    [self.dataTask resume];
}

- (void)stopLoading {
    [self.dataTask cancel];
    self.dataTask = nil;
    self.receivedData = nil;
    self.urlResponse = nil;
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    self.urlResponse = response;
    self.receivedData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.receivedData appendData:data];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error != nil && error.code != NSURLErrorCancelled) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        [self saveCacheResponse];
        [self.client URLProtocolDidFinishLoading:self];
    }
}

/**
 做某些数据相关事情
 */
- (void)saveCacheResponse {
    NSData *timeStamp = [[NSData alloc] init];
    NSString *urlString = self.request.URL.absoluteString;
    NSString *dataString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"TimeStamp:%@ URL:%@ Data:%@", timeStamp, urlString, dataString);
}

@end
