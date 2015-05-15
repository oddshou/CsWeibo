//
//  OHComposePhotosView.m
//  CsWeibo
//
//  Created by niuwan on 15/5/15.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHComposePhotosView.h"
#import "UIView+Extension.h"
#define OHStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation OHComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    
    return self;
}

- (void)addPhoto:(UIImage *)photo
{
    if (self.photos.count >= 9) {
        return;
    }
    
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    // 存储图片
    //    [_photos addObject:photo];
    [self.photos addObject:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = OHStatusPhotoMaxCol(count);
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}

@end
