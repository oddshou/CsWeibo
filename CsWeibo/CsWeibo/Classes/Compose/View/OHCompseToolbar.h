//
//  OHCompseToolbar.h
//  CsWeibo
//
//  Created by niuwan on 15/5/15.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OHComposeToolbarButtonTypeCamera, // 拍照
    OHComposeToolbarButtonTypePicture, // 相册
    OHComposeToolbarButtonTypeMention, // @
    OHComposeToolbarButtonTypeTrend, // #
    OHComposeToolbarButtonTypeEmotion // 表情
}OHCompseToolbarButtonType;

@class OHCompseToolbar;

@protocol OHComposeToolbarDelegate <NSObject>

- (void)composeToolbar:(OHCompseToolbar *)toolbar didClickButton:(OHCompseToolbarButtonType)buttonType;

@end

@interface OHCompseToolbar : UIView

@property (nonatomic, weak) id<OHComposeToolbarDelegate> delegate;


@end
