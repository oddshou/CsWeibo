//
//  OHStatusFrame.m
//  CsWeibo
//
//  Created by niuwan on 15/5/12.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHStatusFrame.h"
#import "OHUser.h"
#import "OHStatus.h"

// cell的边框宽度
#define OHStatusCellBorderW 10

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

- (void)setStatus:(OHStatus *)status
{
    _status = status;
    OHUser *user = status.user;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //头像
#warning 头像图标宽高
    CGFloat iconWH = 35;
    CGFloat iconX = OHStatusCellBorderW;
    CGFloat iconY = OHStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + OHStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:OHStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    //会员图标
    if(user.isVip){
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + OHStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
#warning vip图标宽高
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    

    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + OHStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:OHStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + OHStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:OHStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + OHStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:OHStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    //配图
//    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + OHStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
//        originalH = CGRectGetMaxY(self.photoViewF) + OHStatusCellBorderW;
//    } else { // 没配图
//        originalH = CGRectGetMaxY(self.contentLabelF) + OHStatusCellBorderW;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = OHStatusCellMargin;
    CGFloat originalW = cellW;
//    CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + OHStatusCellBorderW;
    CGFloat originalH = MAX(CGRectGetMaxY(self.contentLabelF), CGRectGetMaxY(self.photoViewF)) + OHStatusCellBorderW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    //转发微博
    if (status.retweeted_status) {
        //取出转发微博体status和user
        OHStatus *retweeted_status = status.retweeted_status;
        OHUser *retweeted_status_user = retweeted_status.user;
        
        //计算转发微博正文
        CGFloat retweetContentX = OHStatusCellBorderW;
        CGFloat retweetContentY = OHStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:OHStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        //计算转发微博配图
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
#warning 转发微博配图宽高
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + OHStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
//            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + HWStatusCellBorderW;
//        } else { // 转发微博没有配图
//            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
        }
        
        //转发微博整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
//        retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
        CGFloat retweetH = MAX(CGRectGetMaxY(self.retweetContentLabelF), CGRectGetMaxY(self.retweetPhotoViewF)) + OHStatusCellBorderW;
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);

    }
    //计算工具条
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    CGFloat toolbarY = MAX(CGRectGetMaxY(self.originalViewF), CGRectGetMaxY(self.retweetViewF));
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF);

}


@end
