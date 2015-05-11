//
//  OHStatus.h
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OHUser;
@interface OHStatus : NSObject

@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) OHUser *user;

@end
