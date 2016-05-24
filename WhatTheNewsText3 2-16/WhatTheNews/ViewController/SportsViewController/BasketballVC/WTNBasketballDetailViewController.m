//
//  WTNBasketballDetailViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNBasketballDetailViewController.h"
#import "WTNNBAVideoModel.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@interface WTNBasketballDetailViewController ()<WKNavigationDelegate>{
    WKWebView *_webView;
}

@end

@implementation WTNBasketballDetailViewController

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
    if (self.NBAVideoModel.url) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.zhibo8.cc/news/web/%@",self.NBAVideoModel.url]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError *  connectionError) {
            NSString * htmlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            // 深拷贝
            NSMutableString * string = [htmlString mutableCopy];
            //删掉数字
            NSRange range = [string rangeOfString:@"<a href=\"http://m.zhibo8.cc/\">直播吧</a>"];
            // NSRange range1 = [string rangeOfString:@"href=\"http://m.zhibo8.cc/\""];
            //  NSRange range1 = [string rangeOfString:@"<name=\"viewport\" content=\"width=device-width, initial-scale=1\""];
            //        NSRange range1 = [string rangeOfString:@"class=\"button\""];
            //        NSRange range2 = [string rangeOfString:@"href=\"javascript:void(0)\""];
            [string replaceCharactersInRange:range withString:@""];
         //   [string replaceCharactersInRange:range1 withString:@""];
            //        [string replaceCharactersInRange:range2 withString:@""];
            [_webView loadHTMLString:string baseURL:url];
        }];
    }
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
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    //关闭HUD
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
//隐藏HUD窗口后调用
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud = nil;
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
