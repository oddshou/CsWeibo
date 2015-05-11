//
//  OHOAuthViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/9.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHOAuthViewController.h"
#import "AFNetworking.h"
#import "OHAccount.h"
#import "OHAccountTools.h"
#import "UIWindow+OHExtension.h"
#import "MBProgressHUD+MJ.h"

@interface OHOAuthViewController () <UIWebViewDelegate>

@end

@implementation OHOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
//    webView.frame = self.view.bounds;
    webView.delegate = self;
    self.view = webView;
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", kAppKey, kRedirectURI];
    NSURL *url = [NSURL URLWithString:urlString];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"----webViewDidFinishLoad");
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"---webViewDidStartLoad");
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

#pragma mark 每次webView 加载前都会调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"%@", request.URL.absoluteString);
    NSString *url = request.URL.absoluteString;
    //判断为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        //截取url后面的code 参数
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        NSLog(@"%@", code);
        //利用code 换取一个accessToken
        [self accessTokenWithCode:code];
        
        //禁止调用回调地址
        return NO;
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = kAppKey;
    params[@"client_secret"] = kAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = kRedirectURI;
    params[@"code"] = code;
    
    [afManager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"请求成功  %@", responseObject);
        //从新浪返回的 responseObject 是字典类型
        OHAccount *account = [OHAccount accountWithDict:responseObject];
        //存储账号信息
        [OHAccountTools saveAccount:account];
        //切换窗口控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        //access_token = @"2.00J5DCLE8XFNAC64fa0f7b933eJ8zB";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 %@", error);
        [MBProgressHUD hideHUD];
    }];
    
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
