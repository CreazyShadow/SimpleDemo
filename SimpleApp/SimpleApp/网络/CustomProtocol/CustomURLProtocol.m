//
//  CustomURLProtocol.m
//  SimpleApp
//
//  Created by wuyp on 2017/2/7.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "CustomURLProtocol.h"

static NSString * const URLProtocolHandledKey = @"URLProtocolHttpKey";

@interface CustomURLProtocol()<NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation CustomURLProtocol

#pragma mark - 是否处理request
//是否打算处理对应的request
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString *scheme = request.URL.scheme;
    //只处理http和https请求
    if ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
        [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
        //判断是否已经处理
        if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark - 对request进行修改 重定向域名等等
//处理对应的request 进行修改
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    mutableReqeust = [self redirectHostInRequset:mutableReqeust];
    return mutableReqeust;
}

//重定向host
+(NSMutableURLRequest*)redirectHostInRequset:(NSMutableURLRequest*)request
{
    if ([request.URL host].length == 0) {
        return request;
    }
    
    NSString *originUrlString = [request.URL absoluteString];
    NSString *originHostString = [request.URL host];
    NSRange hostRange = [originUrlString rangeOfString:originHostString];
    if (hostRange.location == NSNotFound) {
        return request;
    }
    //定向到bing搜索主页
    NSString *ip = @"cn.bing.com";
    
    // 替换域名
    NSString *urlString = [originUrlString stringByReplacingCharactersInRange:hostRange withString:ip];
    NSURL *url = [NSURL URLWithString:urlString];
    request.URL = url;
    
    return request;
}

#pragma mark - 判断请求的request是否重复

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

#pragma mark - 开始和关闭request

- (void)startLoading {
    /* 如果想直接返回缓存的结果，构建一个NSURLResponse对象
     if (cachedResponse) {
     
     NSData *data = cachedResponse.data; //缓存的数据
     NSString *mimeType = cachedResponse.mimeType;
     NSString *encoding = cachedResponse.encoding;
     
     NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
     MIMEType:mimeType
     expectedContentLength:data.length
     textEncodingName:encoding];
     
     [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
     [self.client URLProtocol:self didLoadData:data];
     [self.client URLProtocolDidFinishLoading:self];
     */
    
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableRequest];
    self.connection = [NSURLConnection connectionWithRequest:mutableRequest delegate:self];
}

- (void)stopLoading {
    [self.connection cancel];
}


#pragma mark - NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

@end
