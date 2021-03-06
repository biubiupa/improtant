//
//  AppDelegate.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "RHShujuViewController.h"
#import "RHControlViewController.h"
@interface AppDelegate ()
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) UITabBarController *rootTabVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self realloc];
    [self.window makeKeyAndVisible];
//    [NSThread sleepForTimeInterval:2.0];
    return YES;
}

- (void)realloc {
    self.rootTabVC=[[UITabBarController alloc] init];
    UIViewController *shujuVC=[RHShujuViewController new];
    UIViewController *controlVC=[RHControlViewController new];
    UINavigationController *controlNav=[[UINavigationController alloc] initWithRootViewController:controlVC];
    UINavigationController *dataNav=[[UINavigationController alloc] initWithRootViewController:shujuVC];
//   设置item对应的页面控制器
    self.array=@[dataNav, controlNav];
    self.rootTabVC.viewControllers=self.array;
    self.rootTabVC.tabBar.translucent=NO;
    self.rootTabVC.tabBar.tintColor=CONTROL_COLOR;
    self.rootTabVC.selectedIndex=0;
//设置item的图片
    UITabBarItem *item0=[self.rootTabVC.tabBar.items objectAtIndex:0];
    UITabBarItem *item1=[self.rootTabVC.tabBar.items objectAtIndex:1];
//    UITabBarItem *item2=[self.rootTabVC.tabBar.items objectAtIndex:2];
    item0.title=@"数据";
    item1.title=@"管理";
//    item2.title=@"管理";
    item0.image=[UIImage imageNamed:@"database"];
    item1.image=[UIImage imageNamed:@"control"];
//    item2.image=[UIImage imageNamed:@"control"];
    self.window.rootViewController=self.rootTabVC;
    self.window.backgroundColor=[UIColor whiteColor];
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
