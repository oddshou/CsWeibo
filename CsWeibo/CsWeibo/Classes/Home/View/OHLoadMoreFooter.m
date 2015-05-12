//
//  OHLoadMoreFooter.m
//  CsWeibo
//
//  Created by niuwan on 15/5/12.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHLoadMoreFooter.h"

@implementation OHLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"OHLoadMoreFooter" owner:nil options:nil] firstObject];
}

@end
