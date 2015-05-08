//
//  OHMainTabBarViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHMainTabBarViewController.h"
#import "OHToolsColor.h"
#import "OHMainNaviViewController.h"
#import "OHHomeViewController.h"
#import "OHMessageCenterViewController.h"
#import "OHDiscoverViewController.h"
#import "OHTabBar.h"

@interface OHMainTabBarViewController ()

@end

@implementation OHMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.初始化子控制器
    OHHomeViewController *home = [[OHHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    OHMessageCenterViewController *messageCenter = [[OHMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    OHDiscoverViewController *discover = [[OHDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    UIViewController *profile = [[UIViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置子控制器的文字，会同时设置tabbar和navigationbar的文字
    childVc.title = title;
//    childVc.tabBarItem.title = title;
//    childVc.navigationItem.title = title;
    //设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    //去除ios7的默认渲染（默认渲染成蓝色图片）
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary *textArrts = [NSMutableDictionary dictionary];
    textArrts[NSForegroundColorAttributeName] = OHColor(123, 123, 123, 1.0);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [childVc.tabBarItem setTitleTextAttributes:textArrts forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = OHRandomColor;
    
    //给viewcontroller 设置一个navigationcontroller 使他们有导航栏
    OHMainNaviViewController *nav = [[OHMainNaviViewController alloc] initWithRootViewController:childVc];
//    childVc.view.backgroundColor = OHRandomColor;
    [self addChildViewController:nav];
    
    
    //替换系统 tabbar, kvc tabBar readOnly
    OHTabBar *tabBar = [[OHTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
