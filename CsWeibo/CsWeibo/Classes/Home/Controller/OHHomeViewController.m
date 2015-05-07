//
//  OHHomeViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHHomeViewController.h"
#import "UIBarButtonItem+OHExtension.h"

@implementation OHHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏上面的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnLeft) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnRight) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
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
