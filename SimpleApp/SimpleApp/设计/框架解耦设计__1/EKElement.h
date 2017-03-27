//
//  EKElement.h
//  SimpleApp
//
//  Created by wuyp on 2017/2/23.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKElement : NSObject
{
    Class _viewClass;
}

- (id)createResponder;

@property (nonatomic, assign, readonly) int64_t compareIdentifier;
@property (nonatomic, weak, readonly) UIResponder* uiEventPool;


@end
