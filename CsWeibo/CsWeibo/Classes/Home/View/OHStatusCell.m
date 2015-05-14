//
//  OHStatusCell.m
//  CsWeibo
//
//  Created by niuwan on 15/5/12.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHStatusCell.h"
#import "OHStatusFrame.h"
#import "OHStatus.h"
#import "OHUser.h"
#import "UIImageView+WebCache.h"
#import "OHStatusPhoto.h"
#import "OHToolsColor.h"
#import "OHStatusToolbar.h"
#import "OHStatusPhotosView.h"
#import "OHIconView.h"

@interface OHStatusCell ()

/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) OHIconView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) OHStatusPhotosView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) OHStatusPhotosView *retweetPhotoView;

/** 工具条 */
@property (nonatomic, weak) OHStatusToolbar *toolbar;

@end

@implementation OHStatusCell

#pragma mark source get method
#pragma mark 工具条控件get方法

//- (OHStatusToolbar *)toolbar
//{
//    if (!_toolbar) {
//        OHStatusToolbar *toolbar = [[OHStatusToolbar alloc] init];
//        [self.contentView addSubview:toolbar];
//        _toolbar = toolbar;
//    }
//    return _toolbar;
//}
//
//#pragma mark 转发微博控件get方法
//- (UIView *)retweetView{
//    if (!_retweetView) {
//        UIView *retweetView = [[UIView alloc] init];
//        [self.contentView addSubview:retweetView];
//        retweetView.backgroundColor = OHColor(247, 247, 247, 1.0);
//        _retweetView = retweetView;
//    }
//    return _retweetView;
//}
//
//- (UILabel *)retweetContentLabel
//{
//    if (!_retweetContentLabel) {
//        UILabel *retweetContentLabel = [[UILabel alloc] init];
//        [self.retweetView addSubview:retweetContentLabel];
//        retweetContentLabel.font = OHStatusCellRetweetContentFont;
//        retweetContentLabel.numberOfLines = 0;
//        _retweetContentLabel = retweetContentLabel;
//    }
//    return _retweetContentLabel;
//}
//
//- (UIImageView *)retweetPhotoView
//{
//    if (!_retweetPhotoView) {
//        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
////        retweetPhotoView.contentMode = UIViewContentModeCenter;  //设置拉伸模式
//        [self.retweetView addSubview:retweetPhotoView];
//        _retweetPhotoView = retweetPhotoView;
//    }
//    return _retweetPhotoView;
//}
//
//
//#pragma mark 原创微博控件get方法
//- (UIView *)originalView
//{
//    if (!_originalView) {
//        UIView *originalView = [[UIView alloc] init];
//        [self.contentView addSubview:originalView];
//        originalView.backgroundColor = [UIColor whiteColor];
//        _originalView = originalView;
//    }
//    return _originalView;
//}
//
//- (UIImageView *)iconView
//{
//    if (!_iconView) {
//        UIImageView *iconView = [[UIImageView alloc] init];
//        [self.originalView addSubview:iconView];
//        _iconView = iconView;
//    }
//    return _iconView;
//}
//
//
//- (UIImageView *)vipView
//{
//    if (!_vipView) {
//        UIImageView *vipView = [[UIImageView alloc] init];
//        vipView.contentMode = UIViewContentModeCenter;  //设置拉伸模式
//        [self.originalView addSubview:vipView];
//        _vipView = vipView;
//    }
//    return _vipView;
//}
//
//- (UIImageView *)photoView
//{
//    if (!_photoView) {
//        UIImageView *photoView = [[UIImageView alloc] init];
//        [self.originalView addSubview:photoView];
//        _photoView = photoView;
//    }
//    return _photoView;
//}
//
//- (UILabel *)nameLabel
//{
//    if (!_nameLabel) {
//        UILabel *nameLabel = [[UILabel alloc] init];
//        [self.originalView addSubview:nameLabel];
//        nameLabel.font = OHStatusCellNameFont;
//        _nameLabel = nameLabel;
//    }
//    return _nameLabel;
//}
//
//- (UILabel *)timeLabel
//{
//    if (!_timeLabel) {
//        UILabel *timeLabel = [[UILabel alloc] init];
//        [self.originalView addSubview:timeLabel];
//        timeLabel.font = OHStatusCellTimeFont;
//        _timeLabel = timeLabel;
//    }
//    return _timeLabel;
//}
//- (UILabel *)sourceLabel
//{
//    if (!_sourceLabel) {
//        UILabel *sourceLabel = [[UILabel alloc] init];
//        [self.originalView addSubview:sourceLabel];
//        sourceLabel.font = OHStatusCellSourceFont;
//        _sourceLabel = sourceLabel;
//    }
//    return _sourceLabel;
//}
//- (UILabel *)contentLabel
//{
//    if (!_contentLabel) {
//        UILabel *contentLabel = [[UILabel alloc] init];
//        [self.originalView addSubview:contentLabel];
//        contentLabel.font = OHStatusCellContentFont;
//        contentLabel.numberOfLines = 0; //设置多行
////        contentLabel.backgroundColor = [UIColor yellowColor];
//        _contentLabel = contentLabel;
//    }
//    return _contentLabel;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //点击cell无选中色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        [self setupToolbar];
        
    }
    return self;
}

#pragma mark 初始化view
/**
 * 初始化工具条
 */
- (void)setupToolbar
{
    OHStatusToolbar *toolbar = [[OHStatusToolbar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 * 初始化转发微博
 */
- (void)setupRetweet
{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = OHColor(247, 247, 247, 1.0);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = OHStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    OHStatusPhotosView *retweetPhotoView = [[OHStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 * 初始化原创微博
 */
- (void)setupOriginal
{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    OHIconView *iconView = [[OHIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    OHStatusPhotosView *photoView = [[OHStatusPhotosView alloc] init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = OHStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = OHStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    timeLabel.textColor = [UIColor orangeColor];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = OHStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = OHStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}


- (void)setStatusFrme:(OHStatusFrame *)statusFrme
{
    _statusFrme = statusFrme;
    //获取 status 和 frame
    OHStatus *status = statusFrme.status;
    OHUser *user = status.user;
    
    //原创微博整体
    self.originalView.frame = statusFrme.originalViewF;
    
    //头像
    self.iconView.frame = statusFrme.iconViewF;
    self.iconView.user = user;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //会员图标
    if (user.isVip) {
        self.vipView.frame = statusFrme.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
                self.vipView.hidden = NO;
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
//        if (_vipView) { //从父控件中移除
//            [_vipView removeFromSuperview];
//        }
    }
    
    //昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrme.nameLabelF;
    
    //时间(时间长度会变更，所以需要每次重新计算)
    NSString *time = status.created_at;
    CGFloat timeX = statusFrme.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrme.nameLabelF) + OHStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:OHStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
//    self.timeLabel.text = status.created_at;
//    self.timeLabel.frame = statusFrme.timeLabelF;
    
    /** 来源(时间的长度变更，来源也要相应变更) */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + OHStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:OHStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text =  status.source;
    
//    self.sourceLabel.text = status.source;
//    self.sourceLabel.frame = statusFrme.sourceLabelF;
    
    /** 正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrme.contentLabelF;
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrme.photoViewF;
//        OHStatusPhoto *photo = [status.pic_urls firstObject];
        self.photoView.photos = status.pic_urls;
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//        
        self.photoView.hidden = NO;
    } else {
        self.photoView.hidden = YES;
#warning 应当从父控件当中remove掉
//        if (_photoView) {
//            [_photoView removeFromSuperview];
//        }
    }
//    NSLog(@"username %@, subview%@", user.name, _originalView.subviews);
    // 显示转发的微博
    if (status.retweeted_status) {
        OHStatus *retweeted_status = status.retweeted_status;
        OHUser *retweeted_status_user = retweeted_status.user;
        self.retweetView.hidden = NO;
        //转发的微博整体
        self.retweetView.frame = statusFrme.retweetViewF;
        //微博正文
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrme.retweetContentLabelF;
        //微博配图
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotoView.frame = statusFrme.retweetPhotoViewF;
//            OHStatusPhoto *retweetedPhoto = [retweeted_status.pic_urls firstObject];
            self.retweetPhotoView.photos = retweeted_status.pic_urls;
//                        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetedPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
            self.retweetPhotoView.hidden = NO;
        }else{
            self.retweetPhotoView.hidden = YES;
//            if (_retweetPhotoView) {
//                [_retweetPhotoView removeFromSuperview];
//            }
        }
    }else{
        self.retweetView.hidden = YES;
//        if (_retweetView) {
//            [_retweetView removeFromSuperview];
//        }
    }
    
    //显示工具条
    self.toolbar.frame = statusFrme.toolbarF;
    self.toolbar.status = status;
}

@end







