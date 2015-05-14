//
//  OHStatusPhotoView.h
//  CsWeibo
//
//  Created by niuwan on 15/5/14.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  OHStatusPhotosView 中添加OHStatusPhotoView 
 *  继承自UIImageView 主要添加gif图标
 */

@class OHStatusPhoto;
@interface OHStatusPhotoView : UIImageView

@property (nonatomic, strong) OHStatusPhoto *statusPhoto;

@end
