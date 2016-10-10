//
//  SelectDatePickerView.h
//  SimpleApp
//
//  Created by wuyp on 16/9/26.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDatePickerView : UIView

+ (void)showWithConfirm:(void(^)(NSDate *date))confirm Cancel:(void(^)())cancel;

@end
