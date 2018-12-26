//
//  AppDelegate.m
//  OCBasePro1
//
//  Created by 李东晓 on 2018/12/25.
//  Copyright © 2018年 李东晓. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "LaunchIntroductionView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //关闭设置为NO, 默认值为NO.
    //键盘设置
    [IQKeyboardManager sharedManager].enable = YES;
    //键盘一建回收
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor redColor];
    
    [IQKeyboardManager sharedManager].toolbarBarTintColor = BaseLDXColor;

    
    [[LDXNetworking sharedInstance]networkStatusUnknown:^{
        [[RYHUDManager sharedManager] showWithMessage:@"未知网络" customView:nil hideDelay:2.f];
    } reachable:^{
        [[RYHUDManager sharedManager] showWithMessage:@"无网络" customView:nil hideDelay:2.f];
    } reachableViaWWAN:^{
        [[RYHUDManager sharedManager] showWithMessage:@"您现在是数据网络哦！" customView:nil hideDelay:2.f];
    } reachableViaWiFi:^{
        [[RYHUDManager sharedManager] showWithMessage:@"您现在是Wifi网络哦！" customView:nil hideDelay:2.f];
    }];
    
    MainTabViewController * main = [[MainTabViewController alloc]init];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    
    /*引导页添加*/
    [LaunchIntroductionView sharedWithImages:@[@"ltimg",@"ltimg1",@"ltimg2"]];
    
    
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
