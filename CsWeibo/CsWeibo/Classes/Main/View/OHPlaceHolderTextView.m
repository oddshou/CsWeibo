//
//  OHPlaceHolderTextView.m
//  CsWeibo
//
//  Created by niuwan on 15/5/15.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHPlaceHolderTextView.h"



@implementation OHPlaceHolderTextView


- (void)setLabelPlaceholder:(UILabel *)labelPlaceholder
{
    _labelPlaceholder = labelPlaceholder;
    [self addSubview:_labelPlaceholder];
}

- (void)textDidChange
{
    if (!self.hasText) {
        self.labelPlaceholder.hidden = NO;
    }else{
        self.labelPlaceholder.hidden = YES;
    }
}


#pragma mark 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加通知给自己
        [OHNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

- (void)dealloc{
    [OHNotificationCenter removeObserver:self];
}
         

@end
