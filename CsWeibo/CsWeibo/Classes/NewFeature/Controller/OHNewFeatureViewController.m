//
//  OHNewFeatureViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/9.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHNewFeatureViewController.h"
#import "UIView+Extension.h"
#import "OHToolsColor.h"
#import "OHMainTabBarViewController.h"

#define NewFeatureCount 4

@interface OHNewFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControll;
@end

@implementation OHNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    //2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < NewFeatureCount; i++) {
        //创建等量的uiimageview,(注意这种方式效率不高,可以用uicollectionView的方式实现,效率较高)
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        //最后一个imageview 就往里面添加按钮等其他内容
        if (i == NewFeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    //3.设置scrollView属性
    scrollView.contentSize = CGSizeMake(NewFeatureCount * scrollW, scrollH);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //4.添加pageControll
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewFeatureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = OHColor(253, 98, 98, 1);
    pageControl.pageIndicatorTintColor = OHColor(189, 189, 189, 1);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControll = pageControl;
    
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    //开启交互功能，目的让里面的控件可以交互
    imageView.userInteractionEnabled = YES;
    
    //1.添加 分享 checkbox
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置内边距
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [imageView addSubview:shareBtn];
    
    //2.添加 开始微博按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    NSLog(@"click shareBtn ...");
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    //开始微博,切换到tabbarController
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[OHMainTabBarViewController alloc] init];
    
//    OHMainTabBarViewController *main = [[OHMainTabBarViewController alloc] init];
//    [self presentViewController:main animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //设置pageController 变化
    double page = scrollView.contentOffset.x / scrollView.width;
    //四舍五入计算页码
    self.pageControll.currentPage = (int)(page + 0.5);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
