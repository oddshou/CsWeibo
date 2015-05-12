//
//  OHHomeViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHHomeViewController.h"
#import "UIBarButtonItem+OHExtension.h"
#import "UIView+Extension.h"
#import "OHDropDownWindow.h"
#import "OHTitleButton.h"
#import "AFNetworking.h"
#import "OHAccountTools.h"
#import "OHAccount.h"
#import "OHUser.h"
#import "MJExtension.h"
#import "OHStatus.h"
#import "UIImageView+WebCache.h"


@interface OHHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation OHHomeViewController

- (NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses = [NSMutableArray array];
    }
    
    return _statuses;
}

/**
 *  设置导航栏的内容
 */
- (void)setupNav
{
    //设置导航栏上面的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnLeft) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickBtnRight) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //设置中间标题按钮
    OHTitleButton *titleButton = [[OHTitleButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    
    //设置图片和文字
    NSString *name = [OHAccountTools account].name;
    [titleButton setTitle:(name ? name : @"首页") forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    //    titleButton.imageView.backgroundColor = [UIColor redColor];
    //    titleButton.titleLabel.backgroundColor = [UIColor blueColor];
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
//    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
/**
 *  获取用户昵称,并存储在account中,用于下次初始化直接显示
 */
- (void)setupUserInfo
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    OHAccount *account = [OHAccountTools account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
        OHUser *user = [OHUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [OHAccountTools saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏的内容
    [self setupNav];
    //获取用户信息
    [self setupUserInfo];
    //集成刷新控件
    [self setupRefresh];
}


- (void)setupRefresh
{
    UIRefreshControl *control =[[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
}

#pragma mark UIRefreshControl target
- (void)refreshStateChange:(UIRefreshControl *)control
{
    NSLog(@"refresh....");
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    OHAccount *account = [OHAccountTools account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    OHStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatus.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [OHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新刷新
        [control endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
        
        // 结束刷新刷新
        [control endRefreshing];
    }];
    
}

/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    OHDropDownWindow *popWindow = [OHDropDownWindow DropDownWindow];
    UIView *view = [[UIView alloc] init];
    view.height = 150;
    view.width = 150;
    view.backgroundColor = [UIColor redColor];
    popWindow.content = view;
    
    [popWindow showFrom:titleButton];
}

- (void)clickBtnLeft
{
    NSLog(@"clickBtnLeft...");
    
}

- (void)clickBtnRight
{
     NSLog(@"clickBtnRight...");
}



#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //取出数组中的每一条 OHstatus
    OHStatus *status = self.statuses[indexPath.row];
    OHUser *user = status.user;
    cell.textLabel.text = user.name;
    
    cell.detailTextLabel.text = status.text;
    
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholder];
    
    return cell;
}


@end
