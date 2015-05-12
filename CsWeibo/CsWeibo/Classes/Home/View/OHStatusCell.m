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

@interface OHStatusCell ()

/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation OHStatusCell

#pragma mark source get method
- (UIView *)originalView
{
    if (!_originalView) {
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        _originalView = originalView;
    }
    return _originalView;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.originalView addSubview:iconView];
        _iconView = iconView;
    }
    return _iconView;
}


- (UIImageView *)vipView
{
    if (!_vipView) {
        UIImageView *vipView = [[UIImageView alloc] init];
        [self.originalView addSubview:vipView];
        _vipView = vipView;
    }
    return _vipView;
}

- (UIImageView *)photoView
{
    if (!_photoView) {
        UIImageView *photoView = [[UIImageView alloc] init];
        [self.originalView addSubview:photoView];
        _photoView = photoView;
    }
    return _photoView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.originalView addSubview:nameLabel];
        nameLabel.font = OHStatusCellNameFont;
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.originalView addSubview:timeLabel];
        timeLabel.font = OHStatusCellTimeFont;
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (UILabel *)sourceLabel
{
    if (!_sourceLabel) {
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self.originalView addSubview:sourceLabel];
        sourceLabel.font = OHStatusCellSourceFont;
        _sourceLabel = sourceLabel;
    }
    return _sourceLabel;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] init];
        [self.originalView addSubview:contentLabel];
        contentLabel.font = OHStatusCellContentFont;
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    //此处的重用似乎没有用，应当先判断，再创建
//    if (self) {
//        //判断是否为空
//    }
//    
//    
//    
//    return self;
//}

- (void)setStatusFrme:(OHStatusFrame *)statusFrme
{
    _statusFrme = statusFrme;
    //获取 status 和 frame
    OHStatus *status = statusFrme.status;
    OHUser *user = status.user;
    
    
}

@end
