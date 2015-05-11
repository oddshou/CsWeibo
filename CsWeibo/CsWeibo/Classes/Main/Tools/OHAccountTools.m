//
//  OHAccountTools.m
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHAccountTools.h"
#import "OHAccount.h"

#define OHAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation OHAccountTools

+ (void)saveAccount:(OHAccount *)account
{
    //自定义对象存储必须用NSKeyedArchiver,不再有 writeToFile
    [NSKeyedArchiver archiveRootObject:account toFile:OHAccountPath];
}

+ (OHAccount *)account
{
    //加载模型
    OHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:OHAccountPath];
    
    //授权时给出的过期时间段
    double expires_in = [account.expires_in doubleValue];
    //获取过期时间点
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //当前时间
    NSDate *now = [NSDate date];
    /**
     *  NSOrderedDescending 递减
     *  NSOrderedAscending  递增
     *  NSOrderedSame
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    return account;
}

@end
