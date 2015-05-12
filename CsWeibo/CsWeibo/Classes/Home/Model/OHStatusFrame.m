//
//  OHStatusFrame.m
//  CsWeibo
//
//  Created by niuwan on 15/5/12.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHStatusFrame.h"

@implementation OHStatusFrame

#pragma mark help
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}



@end
