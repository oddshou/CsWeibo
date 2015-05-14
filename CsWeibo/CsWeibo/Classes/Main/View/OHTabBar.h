//
//  OHTabBar.h
//  CsWeibo
//
//  Created by niuwan on 15/5/8.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHTabBar;

@protocol OHTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(OHTabBar *)tabBar;

@end

@interface OHTabBar : UITabBar

@property (nonatomic, assign) id<OHTabBarDelegate> delegate;

@end
