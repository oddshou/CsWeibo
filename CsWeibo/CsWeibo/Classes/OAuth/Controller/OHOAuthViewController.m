//
//  OHOAuthViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/9.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHOAuthViewController.h"

@interface OHOAuthViewController ()

@end

@implementation OHOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
//    webView.frame = self.view.bounds;
//    webView.delegate = self;
    self.view = webView;
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", kAppKey, kRedirectURI];
    NSURL *url = [NSURL URLWithString:urlString];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
