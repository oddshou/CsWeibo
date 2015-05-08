//
//  OHDropDownWindow.h
//  CsWeibo
//  Created by niuwan on 15/5/8.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  功能: 点击一个指定控件(fromView),在对应控件上生成一个指定popWindow
 *  这个控件暂时只设置包含Uiview,若是需要包含Viewcontroller,则需要把自己封装成Viewcontroller。
 */
@interface OHDropDownWindow : UIView
//popWindow 中需要包含的内容View
@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIViewController *contentController;

+ (instancetype)DropDownWindow;


- (void)dismiss;
/**
 *  <#Description#>
 *
 *  @param fromView 我们需要指向的控件view
 */
- (void)showFrom:(UIView *)fromView;

@end
