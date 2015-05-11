//
//  UIWindow+OHExtension.m
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "UIWindow+OHExtension.h"
#import "OHMainTabBarViewController.h"
#import "OHNewFeatureViewController.h"

@implementation UIWindow (OHExtension)

- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //取出上次版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件版本号（info.plist）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[OHMainTabBarViewController alloc] init];
        
    }else{
        self.rootViewController = [[OHNewFeatureViewController alloc] init];
        
        //存储当前版本到沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
