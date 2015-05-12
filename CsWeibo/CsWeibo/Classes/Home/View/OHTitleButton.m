//
//  OHTitleButton.m
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHTitleButton.h"
#import "UIView+Extension.h"

@implementation OHTitleButton

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setBackgroundColor:[UIColor yellowColor]];
//    }
//    
//    return self;
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.取出原先imageView的x值赋给titleLabel
    self.titleLabel.x = self.imageView.x;
    //2.在titleLabel的末尾添加imageView
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

@end
