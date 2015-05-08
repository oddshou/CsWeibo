//
//  OHHomeViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHHomeViewController.h"
#import "UIBarButtonItem+OHExtension.h"
#import "UIView+Extension.h"
#import "OHDropDownWindow.h"

@implementation OHHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏上面的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnLeft) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnRight) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //设置中间标题按钮
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    
    //设置图片和文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    //    titleButton.imageView.backgroundColor = [UIColor redColor];
    //    titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    OHDropDownWindow *popWindow = [OHDropDownWindow DropDownWindow];
    UIView *view = [[UIView alloc] init];
    view.height = 150;
    view.width = 150;
    view.backgroundColor = [UIColor redColor];
    popWindow.content = view;
    
    [popWindow showFrom:titleButton];
}

- (void)clickBtnLeft
{
    NSLog(@"clickBtnLeft...");
    
}

- (void)clickBtnRight
{
     NSLog(@"clickBtnRight...");
}

@end
