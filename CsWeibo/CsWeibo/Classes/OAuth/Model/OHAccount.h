//
//  OHAccount.h
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSNumber *expires_in;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSDate *created_time;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
