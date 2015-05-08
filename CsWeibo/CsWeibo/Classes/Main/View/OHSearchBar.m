//
//  OHSearchBar.m
//  CsWeibo
//
//  Created by niuwan on 15/5/8.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHSearchBar.h"
#import "UIView+Extension.h"

@implementation OHSearchBar


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //设置左边search icon 的大小 30*30
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

+ (instancetype)searchBar
{
    //
    return [[self alloc] init];
}

@end
