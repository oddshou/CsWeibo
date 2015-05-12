//
//  OHUser.h
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHUser : NSObject
/** 字符串型的用户 UID */
@property (nonatomic, copy) NSString *idstr;
/** 好友显示名称 */
@property (nonatomic, copy) NSString *name;
/** 用户头像地址50*50 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 会员类型 > 2 代表会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter = isVip) BOOL vip;

@end
