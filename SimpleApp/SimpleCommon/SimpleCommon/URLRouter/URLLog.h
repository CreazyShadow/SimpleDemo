//
//  URLLog.h
//  SimpleCommon
//
//  Created by wuyp on 16/4/29.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#ifndef URLLog_h
#define URLLog_h

#ifdef DEBUG
#define URLLog(fmt, ...) NSLog(@" %s line:%d\n----------- URLLog -----------\n" fmt @"\n", __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define URLLog(fmt, ...)
#endif

#endif /* YZTURLLog_h */
