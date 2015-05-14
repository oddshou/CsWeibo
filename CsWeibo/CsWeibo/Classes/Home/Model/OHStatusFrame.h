//
//  OHStatusFrame.h
//  CsWeibo
//
//  Created by niuwan on 15/5/12.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// 昵称字体
#define OHStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define OHStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define OHStatusCellSourceFont OHStatusCellTimeFont
// 正文字体
#define OHStatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博的正文字体
#define OHStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

// cell之间的间距
#define OHStatusCellMargin 15
// cell的边框宽度
#define OHStatusCellBorderW 10

@class OHStatus;
/**
 *  包含数据及尺寸信息的模型
 */
@interface OHStatusFrame : NSObject

@property (nonatomic, strong) OHStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect toolbarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
