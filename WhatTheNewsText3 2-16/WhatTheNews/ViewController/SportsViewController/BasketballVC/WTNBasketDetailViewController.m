//
//  WTNBasketDetailViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNBasketDetailViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@interface WTNBasketDetailViewController ()<WKNavigationDelegate>{
     WKWebView *_webView;
}

@end

@implementation WTNBasketDetailViewController

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
    if (_imageUrl) {
        NSURL *url2= [NSURL URLWithString:[NSString stringWithFormat:@"http://m.zhibo8.cc/news/web/%@",_imageUrl]];
        NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
        [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError *  connectionError) {
            NSString * htmlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            // 深拷贝
            NSMutableString * string = [htmlString mutableCopy];
            //删掉数字
            NSRange range = [string rangeOfString:@"<a href=\"http://m.zhibo8.cc/\">直播吧</a>"];
            //        NSRange range = [string rangeOfString:@"+file,function()"];
            //        NSRange range1 = [string rangeOfString:@"class=\"button\""];
            //        NSRange range2 = [string rangeOfString:@"href=\"javascript:void(0)\""];
            [string replaceCharactersInRange:range withString:@""];
          //  [string replaceCharactersInRange:range1 withString:@""];
            //        [string replaceCharactersInRange:range2 withString:@""];
            [_webView loadHTMLString:string baseURL:url2];
        }];
    }
    
    //[_webView loadRequest:request2];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
