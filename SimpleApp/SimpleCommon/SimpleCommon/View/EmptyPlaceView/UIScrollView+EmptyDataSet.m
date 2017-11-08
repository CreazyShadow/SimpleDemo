//
//  UIScrollView+EmptyPlaceHolder.m
//  SimpleCommon
//
//  Created by wuyp on 2017/10/31.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#import "UIScrollView+EmptyDataSet.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "NSObject+Runtime.h"

static void *kCanDisplayEmptyPlaceViewKey   = &kCanDisplayEmptyPlaceViewKey;
static void *kEmptyDataSetSourceDelegateKey = &kEmptyDataSetSourceDelegateKey;
static void *kEmptyPlaceViewKey             = &kEmptyPlaceViewKey;

static NSMutableDictionary<NSString *,NSDictionary *> *_impLookupTable; ///< 缓存实现table <key:class + selector, value:imp info>
static NSString *const kswizzleInfoPointerKey  = @"pointer";
static NSString *const kswizzleInfoOwnerKey    = @"owner";
static NSString *const kswizzleInfoSelectorKey = @"selector";

@implementation UIScrollView (EmptyDataSet)

#pragma mark - swizzle method

NSString *_implementationKey(Class class, SEL selctor) {
    if (!class || !selctor) {
        return nil;
    }
    
    NSString *className = NSStringFromClass([class class]);
    NSString *selName = NSStringFromSelector(selctor);
    return [NSString stringWithFormat:@"%@_%@", className, selName];
}

Class _baseClassToSwizzleForTarget(id target) {
    if ([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    } else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    } else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    
    return nil;
}

void _original_implementation(id self, SEL _cmd) {
    Class baseClass = _baseClassToSwizzleForTarget(self);
    NSString *key = _implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:kswizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    [self empty_reloadData];
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

- (void)swizzleIfPossible:(SEL)selector {
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    
    //如果已经替换，则不需要
    for (NSDictionary *info in _impLookupTable.allValues) {
        Class cls = [info objectForKey:kswizzleInfoOwnerKey];
        NSString *selName = [info objectForKey:kswizzleInfoSelectorKey];
        if ([selName isEqualToString:NSStringFromSelector(selector)] && [self isKindOfClass:cls]) {
            return;
        }
    }
    
    //替换对应的方法和保存origin implementation
    Class baseClass = _baseClassToSwizzleForTarget(self);
    NSString *key = _implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:kswizzleInfoPointerKey];
    
    if (impValue || !key || !baseClass) {
        return;
    }
    
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP newImp = method_setImplementation(method, (IMP)_original_implementation);
    
    NSDictionary *swizzledInfo = @{kswizzleInfoOwnerKey : baseClass,
                                   kswizzleInfoSelectorKey : NSStringFromSelector(selector),
                                   kswizzleInfoPointerKey : [NSValue valueWithPointer:newImp]
                                   };
    [_impLookupTable setObject:swizzledInfo forKey:key];
}

- (void)exchangeReloadDataMethod {
    Class cls = [self class];
    [self swizzleIfPossible:@selector(reloadData)];
    
    if ([cls isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}

- (void)empty_reloadData {
    [self displayEmptyPlaceView];
}

#pragma mark - private

/**
 判断是否需要显示Empty View
 */
- (BOOL)needDisplayEmptyPlaceHolder {
    NSInteger items = 0;
    
    //scrollview
    if (![self respondsToSelector:@selector(reloadData)]) {
        return items;
    }
    
    //tableview
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)self;
        id<UITableViewDataSource> dataSource = tableview.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableview];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableview numberOfRowsInSection:section];
            }
        }
        
        //collectionview
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        id<UICollectionViewDataSource> dataSource = collectionView.dataSource;
       
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}

- (void)displayEmptyPlaceView {
    //先移除前一个View 防止empty view不同从而造成页面存在多个占位图
    [self hidenOrDisplayEmptyPlaceHolderView:NO];
    
    if (!self.canDisplayEmptyPlaceView || [self needDisplayEmptyPlaceHolder]) {
        return;
    }
    
    UIView *emptyPlaceHolder = nil;
    if (self.emptyDataSource && [self.emptyDataSource respondsToSelector:@selector(placeHolderViewForDataSet:)]) {
        emptyPlaceHolder = [self.emptyDataSource placeHolderViewForDataSet:self];
    } else {
        //公共View
        
    }
    
    objc_setAssociatedObject(self, kEmptyPlaceViewKey, emptyPlaceHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //display
    [self hidenOrDisplayEmptyPlaceHolderView:YES];
}

- (void)hidenOrDisplayEmptyPlaceHolderView:(BOOL)display {
    UIView *place = objc_getAssociatedObject(self, kEmptyPlaceViewKey);
    if (![place isKindOfClass:[UIView class]]) {
        return;
    }
    
    //移除
    if (!display) {
        [place removeFromSuperview];
        return;
    }
    
    //不在当前视图上
    if (![place.superview isEqual:self]) {
        CGFloat offsetY = fabs(self.contentOffset.y);
        place.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - offsetY);
        [self addSubview:place];
    }
}

#pragma mark - getter & setter

- (BOOL)canDisplayEmptyPlaceView {
    return [objc_getAssociatedObject(self, kCanDisplayEmptyPlaceViewKey) boolValue];
}

- (void)setCanDisplayEmptyPlaceView:(BOOL)canDisplayEmptyPlaceView {
    [self exchangeReloadDataMethod];
    
    NSNumber *value = [NSNumber numberWithBool:canDisplayEmptyPlaceView];
    objc_setAssociatedObject(self, kCanDisplayEmptyPlaceViewKey, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id<HXEmptyDataSetSource>)emptyDataSource {
    return objc_getAssociatedObject(self, kEmptyDataSetSourceDelegateKey);
}

- (void)setEmptyDataSource:(id<HXEmptyDataSetSource>)emptyDataSource {
    objc_setAssociatedObject(self, kEmptyDataSetSourceDelegateKey, emptyDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
