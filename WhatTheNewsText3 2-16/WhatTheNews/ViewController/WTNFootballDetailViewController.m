//
//  WTNFootballDetailViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/23.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNFootballDetailViewController.h"
#import "WTNTopListModel.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@interface WTNFootballDetailViewController ()<WKNavigationDelegate>{
    WKWebView *_webView;
}

@end

@implementation WTNFootballDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configUI{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    view.backgroundColor = HGColor(73, 152, 231);
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.zhibo8.cc/news/web/%@",self.topListModel.url]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError *  connectionError) {
        NSString * htmlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        // 深拷贝
        NSMutableString * string = [htmlString mutableCopy];
        //删掉数字
         NSRange range = [string rangeOfString:@"<a href=\"http://m.zhibo8.cc/\">直播吧</a>"];
     //   NSRange range1 = [string rangeOfString:@"<a href=\"http://m.zhibo8.cc/download/\">更多新闻请下载直播吧客户端</a>"];
//        NSRange range = [string rangeOfString:@"+file,function()"];
//        NSRange range1 = [string rangeOfString:@"class=\"button\""];
//        NSRange range2 = [string rangeOfString:@"href=\"javascript:void(0)\""];
       [string replaceCharactersInRange:range withString:@""];
//  [string replaceCharactersInRange:range1 withString:@""];
//        [string replaceCharactersInRange:range2 withString:@""];
        [_webView loadHTMLString:string baseURL:url];
    }];

   // [_webView loadRequest:request];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [self.view addSubview:view];
    
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //打开HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //显示的文字
    hud.labelText = @"正在加载...";
}
//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    //关闭HUD
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//}
// 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //关闭HUD
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
//隐藏HUD窗口后调用
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud = nil;
}
@end
