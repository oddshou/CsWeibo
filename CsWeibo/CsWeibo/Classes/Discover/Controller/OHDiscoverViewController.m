//
//  OHDiscoverViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHDiscoverViewController.h"
#import "OHSearchBar.h"
#import "UIView+Extension.h"

@implementation OHDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建搜索框对象
    OHSearchBar *searchBar = [OHSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
}
@end
