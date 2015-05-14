//
//  OHComposeViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/14.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHComposeViewController.h"
#import "OHAccountTools.h"
#import "OHAccount.h"
#import "UIView+Extension.h"


@interface OHComposeViewController ()

@end

@implementation OHComposeViewController


#pragma mark 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏内容
    [self setupNav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //设置title
    NSString *name = [OHAccountTools account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
//            hellp
    }
    
}

#pragma mark 事件方法
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    
}


@end
