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

#import "CustomURLProtocol.h"
#import "SessionCustomProtocolConfiguration.h"

#import <Person.h>

#import "SimpleApp-Swift.h"

#import <Dog.h>
#import <Person.h>

#import <CommonCrypto/CommonCrypto.h>
#import <objc/runtime.h>
#import <objc/message.h>

#import <UserNotifications/UserNotifications.h>

#import "CustomWindow.h"

#import "CustomNavigationController.h"
#import "SubView.h"

#import "MRCObject.h"
#import "RunLoopUtility.h"

//#import <IQKeyboardManager.h>

#import "HXWebViewActionHandler.h"

#import <EmptySuperObj.h>
#import <EmptySubObj.h>
#import <EmptySuperObj+Empty.h>

NSString *const maxCount = @"100";

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong, readwrite) id field;

@property (nonatomic, copy) void(^block1)();
@property (nonatomic, copy) void(^block2)();

@end

@implementation AppDelegate

- (void)test {
    EmptySuperObj *sup = [[EmptySuperObj alloc] init];
    sup.needExchange = YES;
    [sup print];

    EmptySubObj *sub = [[EmptySubObj alloc] init];
    sub.needExchange = YES;
    [sub print];
    
    NSLog(@"%d", [sub isKindOfClass:[EmptySuperObj class]]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //网络请求重定向
    //    [NSURLProtocol registerClass:[CustomURLProtocol class]];
    //    [[SessionCustomProtocolConfiguration shareManager] openHttpProtocol];
    
    //重定向NSLOG
    //    [[LogHelper shareInstance] redirectSTD:STDERR_FILENO];
    
    //捕获crash
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    //测试方法
    [self test];
    
    //    渲染window
    self.window = [[CustomWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //    设置启动方式
    [self setupStartType:0];
    
    [self.window makeKeyAndVisible];
    
    //    [IQKeyboardManager sharedManager].enable = YES;
    
    //通知
//    [self setupNotification];
    
    return YES;
}

- (void)setupStartType:(NSInteger)type {
    UIViewController *vc = nil;
    NSString *className = @"FirstViewController";
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
    
    CustomNavigationController *root = [[CustomNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = root;
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

#pragma mark - Crash收集

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

// 设置一个C函数，用来接收崩溃信息
void uncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSLog(@"崩溃信息：%@ %@ %@", symbols, reason, name);
    
    //    [RunLoopUtility crashRecycle];
}


#pragma mark - 推送iOS9

//后台 ios7之后
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}

#pragma mark - 通知ios10

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //上传token
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //获取token失败，开发调试的时候需要关注 必须的情况下将其上传到异常统计
}

#pragma mark - UNUserNotificationCenterDelegate

//通知即将展示的时候
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    UNNotificationRequest *request = notification.request; //原始请求
    NSDictionary *userInfo = notification.request.content.userInfo; //userInfo数据
    UNNotificationContent *content = request.content;// 原始内容
    NSString *title = content.title; //标题
    NSString *subtitle = content.subtitle; // 副标题
    NSNumber *badge = content.badge; //角标
    NSString *body = content.body; //推送消息体
    UNNotificationSound *sound = content.sound; //指定的声音
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert); //回调此函数将设置导入
}

//用户与通知进行交互后的response，比如说用户直接点开通知打开APP、用户点击通知的按钮或者进行输入文本框的文本
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    //可判断response的种类和request的触发器是什么,可根据远程通知和本地通知分别处理，再根据action进行后续回调
    
    //    //获取在Pending状态下待触发的通知
    //    - (void)getPendingNotificationRequestsWithCompletionHandler:(void(^)(NSArray *requests))completionHandler;
    //    //移除未触发的通知
    //    - (void)removePendingNotificationRequestsWithIdentifiers:(NSArray *)identifiers;
    //    - (void)removeAllPendingNotificationRequests;
    //    // 通知已经触发，但是还在操作系统的通知中心上，可以进行查询和删除
    //    - (void)getDeliveredNotificationsWithCompletionHandler:(void(^)(NSArray *notifications))completionHandler;
    //    - (void)removeDeliveredNotificationsWithIdentifiers:(NSArray *)identifiers;
    //    - (void)removeAllDeliveredNotifications;
}

#pragma mark - ios10本地通知
- (void)localNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"\"Fly to the moon\"";
    content.subtitle = @"by Neo";
    content.body = @"the wonderful song with you~";
    content.badge = @0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"png"];
    NSError *error = nil;
    //将本地图片的路径形成一个图片附件，加入到content中
    UNNotificationAttachment *img_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    content.attachments = @[img_attachment];
    //设置@“”以后，进入app将没有启动页
    content.launchImageName = @"";
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    //设置时间间隔的触发器
    UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    NSString *requestIdentifer = @"time interval request";
    content.categoryIdentifier = @"";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - iOS10 远程通知
- (void)setupNotification {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    //    [center setNotificationCategories:[self createNotificationCategoryActions]];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    
                } else {
                    
                }
            }];
        } else {
            // do other things
        }
    }];
}

@end
