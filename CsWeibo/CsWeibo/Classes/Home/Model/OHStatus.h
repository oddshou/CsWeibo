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
/** 微博ID */
@property (nonatomic, copy) NSString *idstr;
/** 微博内容 */
@property (nonatomic, copy) NSString *text;
/** 微博用户信息 */
@property (nonatomic, strong) OHUser *user;
/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 微博来源 */
@property (nonatomic, copy) NSString *source;

@end
