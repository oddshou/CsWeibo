//
//  OHMainNaviViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHMainNaviViewController.h"
#import "UIBarButtonItem+OHExtension.h"

@interface OHMainNaviViewController ()

@end

@implementation OHMainNaviViewController

/**
 *  类加载的时候调用一次,统一设置一些 style。
 */
+ (void)initialize{
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setTintColor:[UIColor blackColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //    [UINavigationBar appearance];
    //设置不可用状态style,此处设置,disable 下设置 字体大小是无效的
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor greenColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:60];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    //设置普通状态style
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //如果要设置disable 状态下item的字体颜色 需要用下面的渲染,如果不设置那么首次在viewcontroller viewdidload中设置
    //item disable 颜色不会变
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  拦截push进来的viewcontroller
 *  设置默认push出来的viewController 左边返回，右边 更多
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航栏 左右默认内容
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    
}

- (void)more
{
    
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
