//
//  OHComposePhotosView.h
//  CsWeibo
//
//  Created by niuwan on 15/5/15.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHComposePhotosView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *photos;

- (void)addPhoto:(UIImage *)photo;

@end
