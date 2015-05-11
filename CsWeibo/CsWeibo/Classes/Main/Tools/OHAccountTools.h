//
//  OHAccountTools.h
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OHAccount;
@interface OHAccountTools : NSObject

/**
 *  存储账号信息
 *
 *  @param account
 */
+ (void)saveAccount:(OHAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 
 */
+ (OHAccount *)account;

@end
