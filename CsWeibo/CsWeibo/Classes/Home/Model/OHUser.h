//
//  OHUser.h
//  CsWeibo
//
//  Created by niuwan on 15/5/11.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    OHUserVerifiedTypeNone = -1, // 没有任何认证
    
    OHUserVerifiedPersonal = 0,  // 个人认证
    
    OHUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    OHUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    OHUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    OHUserVerifiedDaren = 220 // 微博达人
} OHUserVerifiedType;

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

/** 认证类型 */
@property (nonatomic, assign) OHUserVerifiedType verified_type;

@end
