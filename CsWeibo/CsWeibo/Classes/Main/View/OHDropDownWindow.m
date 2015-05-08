//
//  OHDropDownWindow.m
//  CsWeibo
//
//  Created by niuwan on 15/5/8.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHDropDownWindow.h"
#import "UIView+Extension.h"

@interface OHDropDownWindow ()

@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation OHDropDownWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setContent:(UIView *)content
{
    _content = content;
    //调整内容的位置
    content.x = 10;
    content.y = 15;
    
    //调整内容的宽度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    [self.containerView addSubview:content];
}

- (UIImageView *)containerView
{
    if (!_containerView) {
        //添加一个灰色图片控件
        UIImage *image = [UIImage imageNamed:@"popover_background"];
        _containerView = [[UIImageView alloc] initWithImage:image];
        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

+ (instancetype)DropDownWindow
{
    return [[self alloc] init];
}

- (void)showFrom:(UIView *)fromView
{
    //获取最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    
    //调整fromView 坐标系到window坐标系
    CGRect newFrame = [fromView convertRect:fromView.bounds toView:window];
    self.containerView.y = CGRectGetMaxY(newFrame); //max y
    self.containerView.centerX = CGRectGetMidX(newFrame);   //middle x
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


- (void)dismiss
{
    [self removeFromSuperview];
}


@end
