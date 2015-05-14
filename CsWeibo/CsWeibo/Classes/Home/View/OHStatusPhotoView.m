//
//  OHStatusPhotoView.m
//  CsWeibo
//
//  Created by niuwan on 15/5/14.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "OHStatusPhoto.h"
#import "UIView+Extension.h"

@interface OHStatusPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation OHStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setStatusPhoto:(OHStatusPhoto *)statusPhoto
{
    _statusPhoto = statusPhoto;
    //加载图片
        [self sd_setImageWithURL:[NSURL URLWithString:statusPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 显示\隐藏gif控件
    // 判断是够以gif或者GIF结尾
    self.gifView.hidden = ![statusPhoto.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}


@end
