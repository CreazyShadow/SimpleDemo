//
//  AppDelegate.m
//  SimpleApp
//
//  Created by wuyp on 16/4/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "AppDelegate.h"
#include <sys/signal.h>
#import <LogHelper.h>
#import "GcdViewController.h"
#import "ScrapeView.h"
#import <math.h>

#import <Person.h>

#import "SimpleApp-Swift.h"

#import "NavigationViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong, readwrite) id field;


@end

@implementation AppDelegate

- (void)test {
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [self test];
    //重定向NSLOG
    //    [[LogHelper shareInstance] redirectSTD:STDERR_FILENO];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupStartType:1];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupStartType:(NSInteger)type {
    UIViewController *vc = nil;
    NSString *className = @"AutoLayoutViewController";
    switch (type) {
        case 0:
        {
            vc = [[NSClassFromString(className) alloc] init];
        }
            break;
        case 1:
        {
            vc = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
        }
            break;
        case 2:
            
            break;
    }
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nc;
}

- (UITabBarController *)setupTabBarController {
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    NSArray *vcs = @[@"FirstViewController", @"SecondViewController", @"ImageViewController"];
    for (NSString *vc in vcs) {
        UIViewController *temp = [[NSClassFromString(vc) alloc] init];
        temp.title = vc;
        temp.tabBarItem.title = vc;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:temp];
        [tbc addChildViewController:nc];
    }
    
    return tbc;
}

// 设置一个C函数，用来接收崩溃信息
void uncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSLog(@"崩溃信息：%@ %@ %@", symbols, reason, name);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Open URL


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //    NSLog(@"%@ %@ %@", url, sourceApplication, annotation);
    return YES;
}

- (void)initHandler {
    
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0,sizeof(newSignalAction));
    //    newSignalAction.sa_handler = &signalHandler;
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGSEGV, &newSignalAction, NULL);
    sigaction(SIGFPE, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGPIPE, &newSignalAction, NULL);
    
    //异常时调用的函数
    NSSetUncaughtExceptionHandler(&handleExceptions);
}

void handleExceptions(NSException *exception) {
    NSLog(@"exception = %@",exception);
    NSLog(@"callStackSymbols = %@",[exception callStackSymbols]);
}

@end
