//
//  AppDelegate.m
//  CsWeibo
//
//  Created by niuwan on 15/5/6.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "AppDelegate.h"
//#import "WeiboSDK.h"
#import "OHMainTabBarViewController.h"
#import "OHOAuthViewController.h"
#import "OHNewFeatureViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:@"1835385221"];
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
//    OHMainTabBarViewController *tabBarVc = [[OHMainTabBarViewController alloc] init];
//    self.window.rootViewController = tabBarVc;
    
//    OHOAuthViewController *vc = [[OHOAuthViewController alloc] init];
//    self.window.rootViewController = vc;
    
    NSString *key = @"CFBundleVersion";
    //取出上次版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件版本号（info.plist）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.window.rootViewController = [[OHMainTabBarViewController alloc] init];
    }else{
        self.window.rootViewController = [[OHNewFeatureViewController alloc] init];
        
        //存储当前版本到沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self.window makeKeyAndVisible];
    NSLog(@"bundle path%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    
    return YES;
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

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}

@end
