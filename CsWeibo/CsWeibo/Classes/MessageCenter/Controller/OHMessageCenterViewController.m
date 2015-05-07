//
//  OHMessageCenterViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHMessageCenterViewController.h"
#import "UIBarButtonItem+OHExtension.h"

@implementation OHMessageCenterViewController

/**
 *  懒加载时调用
 */
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置右边发送消息按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(clickBtnRight)];
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnRight) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    NSLog(@"self.navigationitem %@ , self.navigationitem.rightbarbuttonitem %@, enable %d", self.navigationItem, self.navigationItem.rightBarButtonItem, self.navigationItem.rightBarButtonItem.enabled);
    
        self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置初始时这个item不能点击（不能放在viewDidLoad）中，具体原因不明
    //原因：调用view
}

- (void)clickBtnRight
{
    NSLog(@"clickBtnRight message");
}



@end
