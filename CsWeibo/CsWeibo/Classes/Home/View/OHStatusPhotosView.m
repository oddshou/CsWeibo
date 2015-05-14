//
//  OHStatusPhotosView.m
//  CsWeibo
//
//  Created by niuwan on 15/5/14.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHStatusPhotosView.h"
#import "OHStatusPhotoView.h"
#import "UIView+Extension.h"

#define OHStatusPhotoWH 70
#define OHStatusPhotoMargin 10
//只有4张图片显示两列
#define OHStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation OHStatusPhotosView

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = photos.count;
    //创建足够数量的图片控件
    while (self.subviews.count < photosCount) {
        OHStatusPhotoView *photoView = [[OHStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    for (int i = 0; i < self.subviews.count; i++) {
        OHStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { //显示
            photoView.statusPhoto = photos[i];
            photoView.hidden = NO;
        }else{  //隐藏
            photoView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int photosCount = self.photos.count;
    //最大列数
    int maxCols = OHStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        OHStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCols;
        photoView.x = col * (OHStatusPhotoWH + OHStatusPhotoMargin);
        
        int row = i / maxCols;
        
        photoView.y = row * (OHStatusPhotoWH + OHStatusPhotoMargin);
        photoView.width = OHStatusPhotoWH;
        photoView.height = OHStatusPhotoWH;
    }
    
}

+ (CGSize)sizeWithCount:(int)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = OHStatusPhotoMaxCol(count);
    int cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * OHStatusPhotoWH + (cols - 1) * OHStatusPhotoMargin;
    
    //行数
    int rows = (count + cols - 1)/ cols;
    CGFloat photosH = rows * OHStatusPhotoWH + (rows - 1) * OHStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    
}

@end
