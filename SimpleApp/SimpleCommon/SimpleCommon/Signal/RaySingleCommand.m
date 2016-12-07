//
//  RaySingleCommand.m
//  SimpleCommon
//
//  Created by wuyp on 2016/12/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "RaySingleCommand.h"

@interface RaySingleCommand()

@property (nonatomic, strong) NSObject *source;
@property (nonatomic, copy) NSString *prop;

@property (nonatomic, copy) BOOL (^event)(id, NSString *);

@end

@implementation RaySingleCommand

- (void)dealloc {
    [_source removeObserver:self forKeyPath:_prop];
}

- (instancetype)initWithSource:(NSObject *)source property:(NSString *)prop singleBlock:(BOOL (^)(id, NSString *))event {
    if (self = [super init]) {
        self.source = source;
        self.prop = prop;
        self.event = [event copy];
    }
    
    return self;
}

#pragma mark - add kvo

- (void)addNotification {
    [self.source addObserver:self forKeyPath:_prop options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.event(_source,_prop);
}

@end
